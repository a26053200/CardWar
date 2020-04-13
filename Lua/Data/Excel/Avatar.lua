local Data = {
    ["micro_dragon"] = {id = "micro_dragon", name = "Micro Dragon", type = "", hudOffset = "0,0,0", prefabUrl = "Models/Dragon/Prefabs/micro_dragon.prefab"},
    ["Villager_B_Boy"] = {id = "Villager_B_Boy", name = "Villager", type = "", hudOffset = "0,0,0", prefabUrl = "Models/villarger_B_Boy/Prefabs/Villager_B_Boy.prefab"},
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
                
