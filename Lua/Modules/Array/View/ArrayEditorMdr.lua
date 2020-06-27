---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2020-06-17-21:31:19
---

local ArrayCardItem = require("Game.Modules.Array.View.ArrayCardItem")
local BaseMediator = require("Game.Core.Ioc.BaseMediator")
---@class Game.Modules.Array.View.ArrayEditorMdr : Game.Core.Ioc.BaseMediator
---@field arrayModel Game.Modules.Array.Model.ArrayModel
---@field cardModel Game.Modules.Card.Model.CardModel
---@field roleModel Game.Modules.Role.Model.RoleModel
---@field battleModel Game.Modules.Battle.Model.BattleModel
---@field checkPointModel Game.Modules.CheckPoint.Model.CheckPointModel
---@field arrayService Game.Modules.Array.Service.ArrayService
---@field ownerList List | table<number, Game.Modules.Card.Vo.CardVo>
---@field cardList Betel.UI.TableList
---@field selectList List | table<number, Game.Modules.Card.Vo.CardVo>
local ArrayEditorMdr = class("Game.Modules.Array.View.ArrayEditorMdr",BaseMediator)

function ArrayEditorMdr:Ctor()
    ArrayEditorMdr.super.Ctor(self)
    self.layer = UILayer.LAYER_FLOAT
end

function ArrayEditorMdr:OnInit()
    self.ownerList = self.cardModel:SortByStar()

    self:SetCloseBg(self.gameObject:FindChild("Bg"))
    self.cardList = TableList.New(self.gameObject:FindChild("List/ListView"), ArrayCardItem)
    self.cardList:SetData(self.ownerList)
    self.cardList.eventDispatcher:AddEventListener(ListViewEvent.ItemClick, self.onItemClick, self)

    self.arrayService:getBattleArray(self.roleModel.roleId,self.arrayModel.battleType, handler(self, self.OnInitSelectList))
end

function ArrayEditorMdr:OnInitSelectList(data)
    self.selectList = List.New()
    for i = 1, #data.battleArray do
        self.selectList:Add(self.cardModel:GetCardById(data.battleArray[i]))
    end
    self.selectCardList = TableList.New(self.gameObject:FindChild("ListSelect/ListView"), ArrayCardItem)
    self.selectCardList:SetData(self.selectList)
    self.selectCardList:SetScrollEnable(false)
    self.selectCardList.eventDispatcher:AddEventListener(ListViewEvent.ItemClick,self.onSelectItemClick, self)
end

function ArrayEditorMdr:onItemClick(event, data, index)
    if self.selectList:Size() < 5 and not self.selectList:Contain(data) then
        self.selectList:Add(data)
        self.selectCardList:SetData(self.selectList)
        local item = self.cardList:GetItemRenderByIndex(index) ---@type Game.Modules.Array.View.ArrayCardItem
        item.select = true
        item:UpdateItem(data, index)
    end
end

function ArrayEditorMdr:onSelectItemClick(event, data, index)
    if self.selectList:Contain(data) then
        local item = self.cardList:GetItemRenderByData(data) ---@type Game.Modules.Array.View.ArrayCardItem
        self.selectList:Remove(data)
        self.selectCardList:Refresh()
        if item then
            item.select = false
            item:UpdateItem(data, index)
        end
        --self:CreateDelayedFrameCall(function()
        --    self.selectCardList:SetData(self.selectList)
        --end)
    end
end

function ArrayEditorMdr:On_Click_BtnCancel()
    navigation:Pop(ViewConfig.ArrayEditor)
end

function ArrayEditorMdr:On_Click_BtnEnter()
    if self.selectList:Size() == 0 then
        Tips.Show("请选择上场英雄")
        return
    end
    local battleArray = {}
    for i = 1, self.selectList:Size() do
        table.insert(battleArray, self.selectList[i].id)
    end
    self.arrayService:saveBattleArray(self.roleModel.roleId,
            self.arrayModel.battleType,
            battleArray,function(data)
                if data.battleArrayResult then
                    self:OfficialStartBattle()
                end
            end)

end

--正式进入战斗
function ArrayEditorMdr:OfficialStartBattle(battleArray)
    self.arrayService:startBattle(
            self.roleModel.roleId,
            self.checkPointModel.currSection.checkPointData.chapter,
            self.checkPointModel.currSection.checkPointData.id,
            self.arrayModel.battleType,
            battleArray,
            function()
                self.arrayModel.selectList = self.selectList

                navigation:Clear(function()
                    local checkPointData = CheckPointConfig.GetBattleSceneData(self.checkPointModel.currSection.checkPointData.id)
                    self.battleModel.currBattleMode = BattleMode.PVE
                    self.battleModel.currCheckPointData = checkPointData
                    self.battleModel.battleSceneInfo = BattleSceneConfig.Get(checkPointData.battleScene)
                    World.worldScene:EnterCheckPoint(checkPointData.id)
                end)
            end)
end

return ArrayEditorMdr
