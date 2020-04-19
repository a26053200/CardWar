-- Account 2020/4/20 0:20:49
local Data = {}
Data.table = {    ["micro_dragon_atk"] = {id = "micro_dragon_atk", name = "普通攻击", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageAdd = 0},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", name = "技能", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageAdd = 0},
    ["Villager_B_Boy_atk1"] = {id = "Villager_B_Boy_atk1", name = "普通攻击", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.24, damageAdd = 0.1},
    ["Villager_B_Boy_atk2"] = {id = "Villager_B_Boy_atk2", name = "普通攻击", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.45, damageAdd = 0.2},
    ["Villager_B_Boy_atk3"] = {id = "Villager_B_Boy_atk3", name = "普通攻击", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0.66, damageAdd = 0.3},
    ["Villager_B_Boy_skill"] = {id = "Villager_B_Boy_skill", name = "技能", type = "", targetMode = "Enemy", gridSelect = "Current", accountPoint = 0, damageAdd = 0},
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
                
