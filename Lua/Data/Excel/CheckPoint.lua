local Data = {
    [battle_1_1] = {id = "battle_1_1", name = "研究院1", type = "", chapter = 0, section = 1, level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 1, layoutPoints = "p1", layoutPrefabUrl = "Prefabs/Layoputs/Layout_Battle_01.prefab", light = "1", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = 0},
    [battle_1_2] = {id = "battle_1_2", name = "研究院2", type = "", chapter = 0, section = 2, level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 1, layoutPoints = "p2", layoutPrefabUrl = "Prefabs/Layoputs/Layout_Battle_01.prefab", light = "2", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = 0},
    [battle_1_3] = {id = "battle_1_3", name = "研究院3", type = "", chapter = 0, section = 3, level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 1, layoutPoints = "p3", layoutPrefabUrl = "Prefabs/Layoputs/Layout_Battle_01.prefab", light = "3", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = 0},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.Format('There is no id = %s data is table <CheckPoint.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
