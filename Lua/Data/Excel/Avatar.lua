-- Avatar 2020/4/22 0:55:16
local Data = {}
Data.table = {    ["micro_dragon"] = {id = "micro_dragon", name = "Micro Dragon", type = "", hudOffset = "0,110,0", scale = 0.6, animBorn = "dragon_land_on_ground", animIdle = "dragon_idle", animDead = "dragon_die", animRun = "dragon_take_off", animWin = "dragon_laugh", animHit = "dragon_hit_front", prefabUrl = "Models/Dragon/Prefabs/micro_dragon.prefab"},
    ["Villager_B_Boy"] = {id = "Villager_B_Boy", name = "Villager", type = "", hudOffset = "0,110,0", scale = 1.2, animBorn = "DrawDagger", animIdle = "Attackstandy", animDead = "Death", animRun = "Run", animWin = "Elevator", animHit = "Damage", prefabUrl = "Models/villarger_B_Boy/Prefabs/Villager_B_Boy.prefab"},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <Avatar.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
