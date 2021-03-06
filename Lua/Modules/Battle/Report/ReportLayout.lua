---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2020/7/5 11:51
---

---@class Game.Modules.Battle.Report.ReportLayout
---@field unitMap table<Camp, table<number, Game.Modules.Battle.Report.ReportBattleUnit>>
local ReportLayout = class("Game.Modules.Battle.Report.ReportLayout");

function ReportLayout:Ctor()

    self.unitMap = {}
    self.unitMap[Camp.Atk] = {}
    self.unitMap[Camp.Def] = {}
end

function ReportLayout:AddUnit(camp, battleUnit, layoutIndex)
    self.unitMap[camp][layoutIndex] = battleUnit
end

function ReportLayout:RemoveUnit(camp, index)
    self.unitMap[camp][index] = nil
end


function ReportLayout:Clear(camp)
    self.unitMap[camp] = {}
end

function ReportLayout:GetFirstEmptyIndex(camp)
    local layoutGrids = self.unitMap[camp]
    return #layoutGrids + 1
end

--获取首个没有死亡的
---@param camp Camp
---@return Game.Modules.Battle.Report.ReportBattleUnit
function ReportLayout:GetFirstGrid(camp)
    local units = self.unitMap[camp]
    for i = 1, #units do
        local unit = units[i]
        if unit and not unit:IsDead() then
            return unit
        end
    end
    return nil
end

--获取首个没有死亡的
---@param camp Camp
---@return Game.Modules.Battle.Report.ReportBattleUnit
function ReportLayout:GetFirstGridByIndexs(camp, indexs)
    local units = self.unitMap[camp]
    for i = 1, #indexs do
        local unit = units[indexs[i]]
        if unit and not unit:IsDead() then
            return unit
        end
    end
    return nil
end

---@param camp Camp
---@param index number
---@return Game.Modules.Battle.Report.ReportBattleUnit
function ReportLayout:GetUnit(camp, index)
    local units = self.unitMap[camp]
    return units[index]
end

--获取没有死亡的
---@param camp Camp
---@param selectGrids table<number, Game.Modules.Battle.Report.ReportBattleUnit>
function ReportLayout:GetTargetList(camp, selectGrids)
    local targetList = {}
    local units = self.unitMap[camp]
    for i = 1, #selectGrids do
        local unit = units[selectGrids[i]]
        if unit and not unit:IsDead() then
            table.insert(targetList, unit)
        end
    end
    return targetList
end

return ReportLayout