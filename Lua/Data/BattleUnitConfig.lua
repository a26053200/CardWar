---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2019/5/6 17:35
---


--Avatar基础属性
---@class BattleUnitInfo
---@field id string
---@field name string
---@field avatarName string
---@field type BattleUnitType
---@field skills string
---@field cost number
---@field atk number
---@field def number
---@field crit number
---@field critPow number
---@field maxHp number
---@field maxAnger number
---@field speed number

local BattleItemConfig = {}

---@return BattleUnitInfo
function BattleItemConfig.Get(avatarName)
    if BattleItemConfig.data == nil then
        BattleItemConfig.data = require("Game.Data.Excel.BattleUnit")
    end
    local info = BattleItemConfig.data.Get(avatarName) ---@type BattleUnitInfo
    if info == nil then
        logError(string.format("There is not avatar info named %s!", avatarName))
    end
    if isString(info.hudOffset) then
        local hudOffset = info.hudOffset
        info.hudOffset = Tool.ToVector3(hudOffset)
    end
    return info
end

return BattleItemConfig