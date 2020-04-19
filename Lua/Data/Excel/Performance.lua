-- Performance 2020/4/20 0:20:49
local Data = {}
Data.table = {    ["micro_dragon_atk"] = {id = "micro_dragon_atk", name = "普通攻击", type = "Standard", gridSelect = "Current", accountType = "Single", animInfo = "micro_dragon_atk", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = "", accounts = "micro_dragon_atk"},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", name = "技能", type = "Standard", gridSelect = "Current", accountType = "Single", animInfo = "micro_dragon_skill", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = "", accounts = "micro_dragon_skill"},
    ["Villager_B_Boy_atk"] = {id = "Villager_B_Boy_atk", name = "普通攻击", type = "Standard", gridSelect = "Current", accountType = "Multi", animInfo = "Villager_B_Boy_atk", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = "", accounts = "Villager_B_Boy_atk1,Villager_B_Boy_atk2,Villager_B_Boy_atk3"},
    ["Villager_B_Boy_skill"] = {id = "Villager_B_Boy_skill", name = "技能", type = "Standard", gridSelect = "Current", accountType = "Single", animInfo = "Villager_B_Boy_skill", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = "", accounts = "Villager_B_Boy_skill"},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <Performance.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
