-- Battle 2020/4/22 22:57:03
local Data = {}
Data.table = {    [1] = {id = 1, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Micro_Dragon", grid = 1},
    [2] = {id = 2, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Micro_Dragon", grid = 2},
    [3] = {id = 3, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Micro_Dragon", grid = 3},
    [4] = {id = 4, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Ghost", grid = 4},
    [5] = {id = 5, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Ghost", grid = 5},
    [6] = {id = 6, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Ghost", grid = 6},
    [7] = {id = 7, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Werewolf", grid = 7},
    [8] = {id = 8, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Werewolf", grid = 8},
    [9] = {id = 9, pid = "battle_1_1", areaIndex = 1, areaType = "", waveIndex = 1, waveMode = "Trigger", bornMode = "", battleUnit = "Werewolf", grid = 9},
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
                
