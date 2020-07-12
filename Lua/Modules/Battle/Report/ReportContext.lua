---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2020/7/5 0:49
--- 战报上下文
---


local ReportLayout = require("Game.Modules.Battle.Report.ReportLayout")
local ReportBattleUnit = require("Game.Modules.Battle.Report.ReportBattleUnit")

---@class Game.Modules.Battle.Report.ReportContext
---@field New fun(mode : BattleMode)
---@field reportBehavior Game.Modules.Battle.Report.ReportBehavior 行为
---@field layout Game.Modules.Battle.Report.ReportLayout
---@field battleSpeed number 战斗速度
---@field autoUB boolean 自动UB
---@field ubBattleUnit Game.Modules.World.Items.BattleUnit
local ReportContext = class("Game.Modules.Battle.Report.ReportContext")

---@param mode BattleMode
function ReportContext:Ctor(mode)
    self.mode = mode
    self.layout = ReportLayout.New()
    self.ubList = List.New()
end

---@param camp Camp
---@param battleUnitName string
---@return Game.Modules.Battle.Report.ReportBattleUnit
function ReportContext:AddBattleUnit(camp, battleUnitName)
    local layoutIndex = self.layout:GetFirstEmptyIndex(camp)
    if layoutIndex then
        local battleUnitVo = self:CreateBattleUnitVo(camp, battleUnitName, layoutIndex)
        local battleItem = ReportBattleUnit.New(battleUnitVo, self)
        battleItem.layoutIndex = layoutIndex
        self.layout:AddUnit(camp, battleItem, layoutIndex)
        return battleItem
    else
        logError("There is no empty grid")
    end
end

function ReportContext:RemoveBattleUnit(camp, index)
    self.layout:RemoveUnit(camp, index)
end

---@param camp Camp 卡牌
---@param battleUnitName string 单位名字
---@param layoutIndex number
---@return Game.Modules.Battle.Vo.BattleUnitVo
function ReportContext:CreateBattleUnitVo(camp, battleUnitName, layoutIndex)
    local battleUnitVo = World.CreateBattleUnitVo(battleUnitName)
    battleUnitVo.camp = camp
    battleUnitVo.layoutIndex = layoutIndex
    return battleUnitVo
end

--获取某阵营所有单位
---@param camp Camp
---@param includeDead boolean 是否包含死亡单位
---@return List | table<number, Game.Modules.Battle.Report.ReportBattleUnit>
function ReportContext:GetCampUnitList(camp, includeDead)
    local unitList = self.layout.unitMap[camp] ---@type table<number, Game.Modules.Battle.Report.ReportBattleUnit>
    local tempList = List.New()
    for i = 1, #unitList do
        if unitList[i] then
            local checkDead = includeDead and true or (not unitList[i]:IsDead())
            if checkDead and unitList[i].battleUnitVo.layoutIndex ~= 0 then
                tempList:Add(unitList[i])
            end
        end
    end
    return tempList
end

--某阵营是否都以阵亡
---@param camp Camp
function ReportContext:IsCampAllDead(camp)
    local unitList = self.layout.unitMap[camp] ---@type table<number, Game.Modules.Battle.Report.ReportBattleUnit>
    local allDead = true
    for i = 1, #unitList do
        if unitList[i] and not unitList[i]:IsDead() then
            allDead = false
            break;
        end
    end
    return allDead
end

function ReportContext:SetAutoUB(autoUB)
    self.autoUB = autoUB
end

---@param camp Camp
---@param layoutIndex number
function ReportContext:SetUBUnit(camp, layoutIndex)
    local unit = self.layout:GetUnit(camp, layoutIndex)
    self.ubBattleUnit = unit
end

function ReportContext:ClearUBUnit()
    self.ubBattleUnit = nil
end

---@param unit Game.Modules.Battle.Report.ReportBattleUnit
function ReportContext:UseUB(unit)
    if self.autoUB then
        self.ubBattleUnit = nil
        return true
    elseif self.ubBattleUnit == unit then
        return true
    else
        return false
    end
end

function ReportContext:Dispose()

end

return ReportContext