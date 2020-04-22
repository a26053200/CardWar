-- BattleUnit 2020/4/22 22:57:03
local Data = {}
Data.table = {    ["Villager_B_Boy"] = {id = "Villager_B_Boy", name = "Villager", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["Micro_Dragon"] = {id = "Micro_Dragon", name = "Micro Dragon", avatarName = "micro_dragon", type = "Monster", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["Ghost"] = {id = "Ghost", name = "Ghost", avatarName = "Ghost", type = "Monster", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["Werewolf"] = {id = "Werewolf", name = "Werewolf", avatarName = "Werewolf", type = "Monster", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
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
                
