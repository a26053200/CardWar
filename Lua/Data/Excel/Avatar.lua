-- Avatar 2020/4/17 0:04:07
local Data = {
    ["micro_dragon"] = {id = "micro_dragon", name = "Micro Dragon", type = "", hudOffset = "0,0,0", animBorn = "dragon_land_on_ground", animIdle = "dragon_idle", animDead = "dragon_die", animRun = "dragon_take_off", animWin = "dragon_laugh", prefabUrl = "Models/Dragon/Prefabs/micro_dragon.prefab"},
    ["Villager_B_Boy"] = {id = "Villager_B_Boy", name = "Villager", type = "", hudOffset = "0,0,0", animBorn = "", animIdle = "", animDead = "", animRun = "", animWin = "", prefabUrl = "Models/villarger_B_Boy/Prefabs/Villager_B_Boy.prefab"},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.format('There is no id = %s data is table <Avatar.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
