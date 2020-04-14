local Data = {
    [1] = {id = 1, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", avatarName = "micro_dragon", grid = 1},
    [2] = {id = 2, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", avatarName = "micro_dragon", grid = 2},
    [3] = {id = 3, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", avatarName = "micro_dragon", grid = 3},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.format('There is no id = %s data is table <Battle.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
