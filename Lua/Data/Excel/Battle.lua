-- Battle Last Edit By:zheng
local Data = {}
Data.table = 
{
    [1] = {id = 1, pid = "normal_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Micro_Dragon", grid = 1},
    [2] = {id = 2, pid = "normal_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Micro_Dragon", grid = 2},
    [3] = {id = 3, pid = "normal_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Micro_Dragon", grid = 3},
    [4] = {id = 4, pid = "normal_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Micro_Dragon", grid = 4},
    [5] = {id = 5, pid = "normal_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Micro_Dragon", grid = 5},
    [6] = {id = 6, pid = "normal_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Micro_Dragon", grid = 6},
    [7] = {id = 7, pid = "normal_1_1", areaIndex = 2, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Ghost", grid = 1},
    [8] = {id = 8, pid = "normal_1_1", areaIndex = 2, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Werewolf", grid = 2},
    [9] = {id = 9, pid = "normal_1_1", areaIndex = 2, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Ghost", grid = 3},
    [10] = {id = 10, pid = "normal_1_1", areaIndex = 2, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Werewolf", grid = 4},
    [11] = {id = 11, pid = "normal_1_1", areaIndex = 2, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Ghost", grid = 5},
    [12] = {id = 12, pid = "normal_1_1", areaIndex = 2, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Werewolf", grid = 6},
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
                
