---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2020/4/10 23:37
---

local BattleUnit = require("Game.Modules.World.Items.BattleUnit")

---@class WorldContext
---@field New fun(mode : BattleMode, speed : number)
---@field mode BattleMode
---@field id number
---@field checkPointData CheckPointData
---@field battleSceneInfo BattleSceneInfo --战斗场景信息
---@field currSubScene Game.Modules.World.Scenes.Core.SubScene | Game.Modules.World.Scenes.BattleScene  当前子场景
---@field battleBehavior Game.Modules.Battle.Behaviors.BattleBehavior    战场行为
---@field avatarRoot UnityEngine.GameObject
---@field luaReflect Framework.LuaReflect
---@field pool Game.Modules.Common.Pools.AssetPoolProxy 对象池
---@field attachCamera Game.Modules.Common.Components.AttachCamera
---@field battleLayout Game.Modules.Battle.View.BattleLayout
---@field battleSpeed number 战斗速度
local WorldContext = class("WorldContext")

local Sid = 1

---@param mode BattleMode
function WorldContext:Ctor(mode, speed)
    self.id = Sid
    Sid = Sid + 1
    self.mode = mode
    self.battleSpeed = speed
    self.dropList = List.New()
end

function WorldContext:CreateAvatarRoot()
    self.avatarRoot = self.currSubScene:CreateGameObject("AvatarRoot" .. self.id)
    self.luaReflect = self.avatarRoot:AddComponent(typeof(Framework.LuaReflect))
    self.luaReflect:PushLuaFunction("AddBattleUnit",handler(self, self.AddBattleUnit))
    self.luaReflect:PushLuaFunction("RemoveBattleUnit",handler(self, self.RemoveBattleUnit))
end

---@param camp Camp
---@param battleUnitName string
function WorldContext:AddBattleUnit(camp, battleUnitName)
    local emptyGrid = self.battleLayout:GetFirstEmptyGrid(camp)
    if emptyGrid then
        local layoutIndex = emptyGrid.index
        local battleItem = self:CreateBattleItem(camp, battleUnitName, layoutIndex)
        self.battleLayout:AddUnit(battleItem, camp, layoutIndex)
        return battleItem
    else
        logError("There is no empty grid")
    end
end

function WorldContext:RemoveBattleUnit(camp, index)
    local grid = self.battleLayout:GetLayoutGridByIndex(camp, index)
    if grid then
        if grid.owner then
            grid.owner:Dispose()
        end
        grid:ClearOwner()
    else
        logError("There is no empty grid")
    end
end

---@param camp Camp 卡牌
---@param battleUnitName string 单位名字
---@param layoutIndex number
function WorldContext:CreateBattleItem(camp, battleUnitName, layoutIndex)
    local battleItemVo = World.CreateBattleUnitVo(battleUnitName)
    battleItemVo.camp = camp
    battleItemVo.isLeader = layoutIndex == 1
    battleItemVo.index = layoutIndex
    local battleItem = BattleUnit.New(battleItemVo, self)
    return battleItem
end

function WorldContext:SetBattleSpeed(speed)
    self.battleSpeed = speed
end

function WorldContext:Dispose()
    if self.battleBehavior then
        self.battleBehavior:Dispose()
    end
    if self.attachCamera then
        self.attachCamera:Dispose()
    end
    if self.pool then
        self.pool:Dispose()
    end

    Destroy(self.avatarRoot)
    self.avatarRoot = nil
end

return WorldContext