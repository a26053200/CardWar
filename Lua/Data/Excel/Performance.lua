-- Performance Last Edit By:zheng
local Data = {}
Data.table = 
{
    ["Villager_B_Boy_atk"] = {id = "Villager_B_Boy_atk", name = "普通攻击", type = "Standard", gridSelect = "Current", accountType = "Multi", animInfo = "Villager_B_Boy_atk", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
    ["Villager_B_Boy_skill1"] = {id = "Villager_B_Boy_skill1", name = "技能1", type = "Standard", gridSelect = "Col", accountType = "Single", animInfo = "Villager_B_Boy_skill", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
    ["Villager_B_Boy_skill2"] = {id = "Villager_B_Boy_skill2", name = "技能2", type = "Standard", gridSelect = "Row", accountType = "Single", animInfo = "Villager_B_Boy_skill", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
    ["Villager_B_Boy_skill3"] = {id = "Villager_B_Boy_skill3", name = "技能3", type = "Standard", gridSelect = "All", accountType = "Single", animInfo = "Villager_B_Boy_skill", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
    ["micro_dragon_atk"] = {id = "micro_dragon_atk", name = "普通攻击", type = "Standard", gridSelect = "Current", accountType = "Single", animInfo = "micro_dragon_atk", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", name = "技能", type = "Standard", gridSelect = "Current", accountType = "Multi", animInfo = "micro_dragon_skill", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
    ["Ghost_atk"] = {id = "Ghost_atk", name = "普通攻击", type = "Standard", gridSelect = "Current", accountType = "Single", animInfo = "Ghost_atk", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
    ["Ghost_skill"] = {id = "Ghost_skill", name = "技能", type = "Standard", gridSelect = "Current", accountType = "Multi", animInfo = "Ghost_skill", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
    ["Werewolf_atk"] = {id = "Werewolf_atk", name = "普通攻击", type = "Standard", gridSelect = "Current", accountType = "Single", animInfo = "Werewolf_atk", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
    ["Werewolf_skill"] = {id = "Werewolf_skill", name = "技能", type = "Standard", gridSelect = "Current", accountType = "Multi", animInfo = "Werewolf_skill", duration = 0, interval = 0, delay = 0, times = 1, param = "", shake = ""},
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
                
