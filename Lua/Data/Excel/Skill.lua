-- Skill 2020/4/28 0:50:27
local Data = {}
Data.table = {    ["Villager_B_Boy_atk"] = {id = "Villager_B_Boy_atk", owner = "Villager_B_Boy", name = "普通攻击", type = "Normal", triggerCondition = "CD|0", cd = 0, priority = 1, damageAdd = 1, crit = 0, critPow = 0, performance = "Villager_B_Boy_atk"},
    ["Villager_B_Boy_skill1"] = {id = "Villager_B_Boy_skill1", owner = "Villager_B_Boy", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 2, priority = 2, damageAdd = 1, crit = 0, critPow = 0, performance = "Villager_B_Boy_skill1"},
    ["Villager_B_Boy_skill2"] = {id = "Villager_B_Boy_skill2", owner = "Villager_B_Boy", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 2, priority = 3, damageAdd = 1, crit = 0, critPow = 0, performance = "Villager_B_Boy_skill2"},
    ["Villager_B_Boy_skill3"] = {id = "Villager_B_Boy_skill3", owner = "Villager_B_Boy", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 2, priority = 4, damageAdd = 1, crit = 0, critPow = 0, performance = "Villager_B_Boy_skill3"},
    ["micro_dragon_atk"] = {id = "micro_dragon_atk", owner = "Micro_Dragon", name = "普通攻击", type = "Normal", triggerCondition = "CD|0", cd = 0, priority = 1, damageAdd = 1, crit = 0, critPow = 0, performance = "micro_dragon_atk"},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", owner = "Micro_Dragon", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 0, priority = 2, damageAdd = 1, crit = 0, critPow = 0, performance = "micro_dragon_skill"},
    ["Ghost_atk"] = {id = "Ghost_atk", owner = "Ghost", name = "普通攻击", type = "Normal", triggerCondition = "CD|0", cd = 0, priority = 1, damageAdd = 1, crit = 0, critPow = 0, performance = "Ghost_atk"},
    ["Ghost_skill"] = {id = "Ghost_skill", owner = "Ghost", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 0, priority = 2, damageAdd = 1, crit = 0, critPow = 0, performance = "Ghost_skill"},
    ["Werewolf_atk"] = {id = "Werewolf_atk", owner = "Werewolf", name = "普通攻击", type = "Normal", triggerCondition = "CD|0", cd = 0, priority = 1, damageAdd = 1, crit = 0, critPow = 0, performance = "Werewolf_atk"},
    ["Werewolf_skill"] = {id = "Werewolf_skill", owner = "Werewolf", name = "技能", type = "Skill", triggerCondition = "Prob|0.3", cd = 0, priority = 2, damageAdd = 1, crit = 0, critPow = 0, performance = "Werewolf_skill"},
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
                
