-- BattleUnit 2020/4/22 0:55:16
local Data = {}
Data.table = {    ["micro_dragon"] = {id = "micro_dragon", name = "Micro Dragon", avatarName = "micro_dragon", type = "Monster", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["Villager_B_Boy"] = {id = "Villager_B_Boy", name = "Villager", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <BattleUnit.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
