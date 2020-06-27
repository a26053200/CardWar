-- BattleScene Last Edit By:zheng
local Data = {}
Data.table = 
{
    ["scene1"] = {id = "scene1", name = "新手引导1", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p1", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_01.prefab", light = "1", cameraDistance = 11, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene2"] = {id = "scene2", name = "新手引导2", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p2", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_02.prefab", light = "2", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene3"] = {id = "scene3", name = "新手引导3", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p3", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_03.prefab", light = "3", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene4"] = {id = "scene4", name = "研究院1", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p1", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_01.prefab", light = "1", cameraDistance = 11, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene5"] = {id = "scene5", name = "研究院2", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p2", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_02.prefab", light = "2", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene6"] = {id = "scene6", name = "研究院3", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p3", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_03.prefab", light = "3", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene7"] = {id = "scene7", name = "新手引导1", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p1", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_01.prefab", light = "1", cameraDistance = 11, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene8"] = {id = "scene8", name = "新手引导2", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p2", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_02.prefab", light = "2", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene9"] = {id = "scene9", name = "新手引导3", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p3", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_03.prefab", light = "3", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene10"] = {id = "scene10", name = "研究院1", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p1", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_01.prefab", light = "1", cameraDistance = 11, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene11"] = {id = "scene11", name = "研究院2", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p2", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_02.prefab", light = "2", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
    ["scene12"] = {id = "scene12", name = "研究院3", level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p3", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_03.prefab", light = "3", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0"},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <BattleScene.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
