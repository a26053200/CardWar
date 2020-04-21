﻿-- Skill 2020/4/22 0:55:16
local Data = {}
Data.table = {    ["micro_dragon_atk"] = {id = "micro_dragon_atk", owner = "micro_dragon", name = "普通攻击", type = "Normal", triggerCondition = "CD|0", cd = 0, priority = 1, damageAdd = 1, crit = 0, critPow = 0, performance = "micro_dragon_atk"},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", owner = "micro_dragon", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 0, priority = 2, damageAdd = 1, crit = 0, critPow = 0, performance = "micro_dragon_skill"},
    ["Villager_B_Boy_atk"] = {id = "Villager_B_Boy_atk", owner = "Villager_B_Boy", name = "普通攻击", type = "Normal", triggerCondition = "CD|0", cd = 0, priority = 1, damageAdd = 1, crit = 0, critPow = 0, performance = "Villager_B_Boy_atk"},
    ["Villager_B_Boy_skill1"] = {id = "Villager_B_Boy_skill1", owner = "Villager_B_Boy", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 2, priority = 2, damageAdd = 1, crit = 0, critPow = 0, performance = "Villager_B_Boy_skill1"},
    ["Villager_B_Boy_skill2"] = {id = "Villager_B_Boy_skill2", owner = "Villager_B_Boy", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 2, priority = 3, damageAdd = 1, crit = 0, critPow = 0, performance = "Villager_B_Boy_skill2"},
    ["Villager_B_Boy_skill3"] = {id = "Villager_B_Boy_skill3", owner = "Villager_B_Boy", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 2, priority = 4, damageAdd = 1, crit = 0, critPow = 0, performance = "Villager_B_Boy_skill3"},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <Skill.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
