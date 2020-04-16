-- BattleUnit 2020/4/17 0:04:07
local Data = {
    ["micro_dragon"] = {id = "micro_dragon", name = "Micro Dragon", avatarName = "Micro Dragon", type = "Monster", cost = 10, atk = 100, def = 100, maxHp = 1000, maxAnger = 100, speed = 60},
    ["Villager_B_Boy"] = {id = "Villager_B_Boy", name = "Villager", avatarName = "Villager", type = "Hero", cost = 10, atk = 100, def = 100, maxHp = 1000, maxAnger = 100, speed = 60},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.format('There is no id = %s data is table <BattleUnit.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
