-- CheckPoint Last Edit By:zheng
local Data = {}
Data.table = {    ["battle_1_1"] = {id = "battle_1_1", name = "新手引导1", type = "normal", chapter = 0, section = 1, level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p1", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_01.prefab", light = "1", cameraDistance = 11, cameraAngle = "30,135,0", cameraOffset = "0,0,0", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece1.png"},
    ["battle_1_2"] = {id = "battle_1_2", name = "新手引导2", type = "normal", chapter = 0, section = 2, level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p2", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_02.prefab", light = "2", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece2.png"},
    ["battle_1_3"] = {id = "battle_1_3", name = "新手引导3", type = "normal", chapter = 0, section = 3, level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p3", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_03.prefab", light = "3", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece3.png"},
    ["battle_2_1"] = {id = "battle_2_1", name = "研究院1", type = "normal", chapter = 1, section = 1, level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p1", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_01.prefab", light = "1", cameraDistance = 11, cameraAngle = "30,135,0", cameraOffset = "0,0,0", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece4.png"},
    ["battle_2_2"] = {id = "battle_2_2", name = "研究院2", type = "normal", chapter = 1, section = 2, level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p2", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_02.prefab", light = "2", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece5.png"},
    ["battle_2_3"] = {id = "battle_2_3", name = "研究院3", type = "normal", chapter = 1, section = 3, level = "pve_research_1_UH", layoutDistance = 10, layoutGridSize = 2, layoutPoints = "p3", layoutPrefabUrl = "Prefabs/Layouts/Layout_Battle_03.prefab", light = "3", cameraDistance = 13, cameraAngle = "30,135,0", cameraOffset = "0,0,0", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece6.png"},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <CheckPoint.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
