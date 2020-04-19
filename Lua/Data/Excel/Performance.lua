-- Performance 2020/4/19 16:54:32
local Data = {}
Data.table = {    ["micro_dragon_atk"] = {id = "micro_dragon_atk", name = "普通攻击", type = "Standard", gridSelect = "Current", animInfo = "micro_dragon_atk", duration = 0, interval = 0, delay = 0, times = 1, accounts = "micro_dragon_atk", param = "", shake = ""},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", name = "技能", type = "Standard", gridSelect = "Current", animInfo = "micro_dragon_skill", duration = 0, interval = 0, delay = 0, times = 1, accounts = "micro_dragon_skill", param = "", shake = ""},
    ["Villager_B_Boy_atk"] = {id = "Villager_B_Boy_atk", name = "普通攻击", type = "Standard", gridSelect = "Current", animInfo = "micro_dragon_atk", duration = 0, interval = 0, delay = 0, times = 1, accounts = "Villager_B_Boy_atk", param = "", shake = ""},
    ["Villager_B_Boy_skill"] = {id = "Villager_B_Boy_skill", name = "技能", type = "Standard", gridSelect = "Current", animInfo = "micro_dragon_skill", duration = 0, interval = 0, delay = 0, times = 1, accounts = "Villager_B_Boy_skill", param = "", shake = ""},
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
                
