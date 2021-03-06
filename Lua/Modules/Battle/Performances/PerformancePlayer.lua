---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2020/4/18 23:00
---



local Widget = require("Game.Modules.Common.Components.Widget")
---@class Game.Modules.Battle.Performances.PerformancePlayer : Game.Modules.Common.Components.Widget
---@field battleUnit Game.Modules.World.Items.BattleUnit
---@field performanceList List | table<number, Game.Modules.Battle.Performances.PerformanceBase>
local PerformancePlayer = class("Game.Modules.Battle.Performances.PerformancePlayer",Widget)

---@param battleUnit Game.Modules.World.Items.BattleUnit
function PerformancePlayer:Ctor(battleUnit)
    self.battleUnit = battleUnit
    self.performanceList = List.New()
    PerformancePlayer.super.Ctor(self, battleUnit.gameObject)
end

---@param performanceName string
---@return Game.Modules.Battle.Performances.PerformanceBase
function PerformancePlayer:Create(performanceName)
    if StringUtil.IsEmpty(performanceName) then
        return nil
    end
    local performanceInfo = PerformanceConfig.Get(performanceName)
    if performanceInfo then
        --if performanceInfo.prob <= math.random() then
        --    return nil
        --end
        --优化时，下面处理可以考虑对象池
        local performance ---@type Game.Modules.Battle.Performances.PerformanceBase
        local performanceType = require("Game.Modules.Battle.Performances." .. performanceInfo.type)
        if performanceType == nil then
            logError("Unknown performance type!")
            return nil
        end
        performance = performanceType.New(self.battleUnit, performanceInfo)
        self.performanceList:Add(performance)
        return performance
    else
        logError("There is no performance name:" .. tostring(performanceName))
        return nil
    end
end

---@param performance Game.Modules.Battle.Performances.PerformanceBase
---@param overCallback Handler | fun()
function PerformancePlayer:PlayOnly(performance, overCallback, ...)
    performance:Play(function(success)
        if overCallback then
            if isFunction(overCallback) then
                overCallback(success)
            else
                overCallback:Execute(success)
            end
        end
        if self.performanceList:Contain(performance) then
            self.performanceList:Remove(performance)
        end
        performance:Dispose()
    end, ...)
end

---@param performance string
---@param overCallback Handler | fun()
---@return Game.Modules.Battle.Performances.PerformanceBase
function PerformancePlayer:Play(performance, overCallback, ...)
    local tempPerformance = self:Create(performance)
    if tempPerformance then
        self:PlayOnly(tempPerformance, overCallback, ...)
    end
    return tempPerformance
end

--是否有当前表现
---@param performanceName string
---@return Game.Modules.Battle.Performances.PerformanceBase
function PerformancePlayer:GetPerformance(performanceName)
    for i = 1, self.performanceList:Size() do
        --禁止替换
        if self.performanceList[i].performanceInfo.replaceMode == ReplaceMode.Forbid
                and self.performanceList[i].performanceInfo.id == performanceName then
            return self.performanceList[i]
        end
    end
    return nil
end

---@param performanceName string
function PerformancePlayer:Stop(performanceName)
    local p = self:GetPerformance(performanceName)
    if p then
        p:Dispose()
        self.performanceList:Remove(p)
    end
end

function PerformancePlayer:Dispose()
    PerformancePlayer.super.Dispose(self)
    for i = 1, self.performanceList:Size() do
        self.performanceList[i]:Dispose()
    end
    self.performanceList:Clear()
end

return PerformancePlayer