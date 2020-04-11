local Data = {
    [micro_dragon] = {id = 0, name = "Micro Dragon", type = "", hudOffset = "0,0,0", prefabUrl = "Prefabs/Layoputs/Layout_Battle_01.prefab"},
    [Villager_B_Boy] = {id = 0, name = "Villager", type = "", hudOffset = "0,0,0", prefabUrl = "Prefabs/Layoputs/Layout_Battle_01.prefab"},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.Format('There is no id = %s data is table <Avatar.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
