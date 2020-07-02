-- Account Last Edit By:zheng
local Data = {}
Data.table = 
{
    ["Villager_B_Boy_atk1"] = {id = "Villager_B_Boy_atk1", name = "普通攻击", group = "Villager_B_Boy_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.24, damageRatio = 0.3333333},
    ["Villager_B_Boy_atk2"] = {id = "Villager_B_Boy_atk2", name = "普通攻击", group = "Villager_B_Boy_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.45, damageRatio = 0.3333333},
    ["Villager_B_Boy_atk3"] = {id = "Villager_B_Boy_atk3", name = "普通攻击", group = "Villager_B_Boy_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.66, damageRatio = 0.3333333},
    ["Villager_B_Boy_skill1"] = {id = "Villager_B_Boy_skill1", name = "技能1", group = "Villager_B_Boy_skill1", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageRatio = 1},
    ["Villager_B_Boy_skill2"] = {id = "Villager_B_Boy_skill2", name = "技能2", group = "Villager_B_Boy_skill2", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageRatio = 1},
    ["Villager_B_Boy_skill3"] = {id = "Villager_B_Boy_skill3", name = "技能3", group = "Villager_B_Boy_skill3", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageRatio = 1},
    ["micro_dragon_atk"] = {id = "micro_dragon_atk", name = "普通攻击", group = "micro_dragon_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageRatio = 1},
    ["micro_dragon_skill1"] = {id = "micro_dragon_skill1", name = "技能1", group = "micro_dragon_skill", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.14, damageRatio = 0.3333333},
    ["micro_dragon_skill2"] = {id = "micro_dragon_skill2", name = "技能2", group = "micro_dragon_skill", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.45, damageRatio = 0.3333333},
    ["micro_dragon_skill3"] = {id = "micro_dragon_skill3", name = "技能3", group = "micro_dragon_skill", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.71, damageRatio = 0.3333333},
    ["Ghost_atk"] = {id = "Ghost_atk", name = "普通攻击", group = "Ghost_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageRatio = 1},
    ["Ghost_skill"] = {id = "Ghost_skill", name = "技能1", group = "Ghost_skill", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.14, damageRatio = 1},
    ["Werewolf_atk"] = {id = "Werewolf_atk", name = "普通攻击", group = "Werewolf_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageRatio = 1},
    ["Werewolf_skill"] = {id = "Werewolf_skill", name = "技能1", group = "Werewolf_skill", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.14, damageRatio = 1},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <Account.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
