-- Account 2020/4/22 0:55:16
local Data = {}
Data.table = {    ["micro_dragon_atk"] = {id = "micro_dragon_atk", name = "普通攻击", group = "micro_dragon_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageAdd = 0},
    ["micro_dragon_skill1"] = {id = "micro_dragon_skill1", name = "技能1", group = "micro_dragon_skill", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.14, damageAdd = 0},
    ["micro_dragon_skill2"] = {id = "micro_dragon_skill2", name = "技能2", group = "micro_dragon_skill", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.45, damageAdd = 0},
    ["micro_dragon_skill3"] = {id = "micro_dragon_skill3", name = "技能3", group = "micro_dragon_skill", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.71, damageAdd = 0},
    ["Villager_B_Boy_atk1"] = {id = "Villager_B_Boy_atk1", name = "普通攻击", group = "Villager_B_Boy_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.24, damageAdd = 0.1},
    ["Villager_B_Boy_atk2"] = {id = "Villager_B_Boy_atk2", name = "普通攻击", group = "Villager_B_Boy_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.45, damageAdd = 0.2},
    ["Villager_B_Boy_atk3"] = {id = "Villager_B_Boy_atk3", name = "普通攻击", group = "Villager_B_Boy_atk", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.66, damageAdd = 0.3},
    ["Villager_B_Boy_skill1"] = {id = "Villager_B_Boy_skill1", name = "技能1", group = "Villager_B_Boy_skill1", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageAdd = 0},
    ["Villager_B_Boy_skill2"] = {id = "Villager_B_Boy_skill2", name = "技能2", group = "Villager_B_Boy_skill2", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageAdd = 0},
    ["Villager_B_Boy_skill3"] = {id = "Villager_B_Boy_skill3", name = "技能3", group = "Villager_B_Boy_skill3", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageAdd = 0},
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
                
