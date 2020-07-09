---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2019-09-17-00:16:13
---

local BattleHeroItem = require("Game.Modules.Battle.View.BattleHeroItem")
local BattleEvents = require("Game.Modules.Battle.Events.BattleEvents")
local BaseMediator = require("Game.Core.Ioc.BaseMediator")

---@class Game.Modules.Battle.View.BattleInfoMdr : Game.Core.Ioc.BaseMediator
---@field battleModel Game.Modules.Battle.Model.BattleModel
---@field battleConfigModel Game.Modules.BattleConfig.Model.BattleConfigModel
---@field battleService Game.Modules.Battle.Service.BattleService
---@field battleConfigService Game.Modules.BattleConfig.Service.BattleConfigService
---@field scoreText UnityEngine.UI.Text
---@field heroList List | table<number, Game.Modules.World.Items.BattleUnit>
local BattleInfoMdr = class("BattleInfoMdr",BaseMediator)

local SpeedValues = {1,1.8,2.5}

function BattleInfoMdr:OnInit()
    self.context = self.battleModel.currentContext
    self.heroList = self.context.battleBehavior:GetCampAvatarList(Camp.Atk)

    self.speedIndex = self.battleConfigModel.battleSpeed
    self.gameObject:SetButtonText("BtnSpeed", "x" .. self.speedIndex)

    self.heroListView = TableList.New(self.gameObject:FindChild("HeroList"), BattleHeroItem)
    self.heroListView:SetData(self.heroList)
    self.heroListView:SetScrollEnable(false)
    self.heroListView.eventDispatcher:AddEventListener(ListViewEvent.ItemClick, self.onHeroItemClick, self)
end


function BattleInfoMdr:RegisterListeners()

end

---@param data Game.Modules.World.Items.BattleUnit
function BattleInfoMdr:onHeroItemClick(event, data, index)
    if data.battleUnitVo.curTp >= data.battleUnitVo.maxTp then
        print("UBUBUBUBUBUUBBUBU")
    end
end

function BattleInfoMdr:On_Click_BtnAuto()

end

function BattleInfoMdr:On_Click_BtnSpeed()
    if self.speedIndex + 1 > #SpeedValues then
        self.speedIndex = 1
    else
        self.speedIndex = self.speedIndex + 1
    end
    self.context.battleSpeed = SpeedValues[self.speedIndex]
    BattleEvents.Dispatch(BattleEvents.BattleSpeedChanged)
    self.gameObject:SetButtonText("BtnSpeed", "x" .. self.speedIndex)
    self.battleConfigService:SaveBattleConfig(
            self.roleModel.roleId,
            self.battleConfigModel.battleType,
            self.speedIndex,false)
end

function BattleInfoMdr:Update()
    if self.scoreText then
        self.scoreText.text = Game.ECSWorld.Instance.score .. ""
    end
end

return BattleInfoMdr
