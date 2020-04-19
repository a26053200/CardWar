-- Battle 2020/4/20 0:20:49
local Data = {}
Data.table = {    [1] = {id = 1, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "micro_dragon", grid = 1},
    [2] = {id = 2, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "micro_dragon", grid = 2},
    [3] = {id = 3, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "micro_dragon", grid = 3},
    [4] = {id = 4, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "micro_dragon", grid = 4},
    [5] = {id = 5, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "micro_dragon", grid = 5},
    [6] = {id = 6, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "micro_dragon", grid = 6},
    [7] = {id = 7, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "micro_dragon", grid = 7},
    [8] = {id = 8, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "micro_dragon", grid = 8},
    [9] = {id = 9, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "micro_dragon", grid = 9},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <Battle.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
