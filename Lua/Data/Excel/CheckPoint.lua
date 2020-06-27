-- CheckPoint Last Edit By:zheng
local Data = {}
Data.table = 
{
    ["normal_1_1"] = {id = "normal_1_1", name = "新手引导1", battleScene = "scene1", type = "Normal", chapter = 100000, section = 1, strength = 1, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p1", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece1.png"},
    ["normal_1_2"] = {id = "normal_1_2", name = "新手引导2", battleScene = "scene2", type = "Normal", chapter = 100000, section = 2, strength = 1, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p2", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece2.png"},
    ["normal_1_3"] = {id = "normal_1_3", name = "新手引导3", battleScene = "scene3", type = "Normal", chapter = 100000, section = 3, strength = 1, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p3", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece3.png"},
    ["normal_2_1"] = {id = "normal_2_1", name = "研究院1", battleScene = "scene4", type = "Normal", chapter = 100001, section = 1, strength = 1, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p1", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece4.png"},
    ["normal_2_2"] = {id = "normal_2_2", name = "研究院2", battleScene = "scene5", type = "Normal", chapter = 100001, section = 2, strength = 1, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p2", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece5.png"},
    ["normal_2_3"] = {id = "normal_2_3", name = "研究院3", battleScene = "scene6", type = "Normal", chapter = 100001, section = 3, strength = 1, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p3", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece6.png"},
    ["hard_1_1"] = {id = "hard_1_1", name = "新手引导1", battleScene = "scene7", type = "Hard", chapter = 200001, section = 1, strength = 3, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p1", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece1.png"},
    ["hard_1_2"] = {id = "hard_1_2", name = "新手引导2", battleScene = "scene8", type = "Hard", chapter = 200001, section = 2, strength = 3, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p2", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece2.png"},
    ["hard_1_3"] = {id = "hard_1_3", name = "新手引导3", battleScene = "scene9", type = "Hard", chapter = 200001, section = 3, strength = 3, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p3", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece3.png"},
    ["hard_2_1"] = {id = "hard_2_1", name = "研究院1", battleScene = "scene10", type = "Hard", chapter = 200002, section = 1, strength = 3, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p1", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece4.png"},
    ["hard_2_2"] = {id = "hard_2_2", name = "研究院2", battleScene = "scene11", type = "Hard", chapter = 200002, section = 2, strength = 3, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p2", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece5.png"},
    ["hard_2_3"] = {id = "hard_2_3", name = "研究院3", battleScene = "scene12", type = "Hard", chapter = 200002, section = 3, strength = 3, maxPassNum = 0, maxResetNum = 0, firstRewardId = "2", rewardId = "p3", uiLayoutUrl = "Prefabs/UI/CheckPoint/MapLayout0.prefab", iconUrl = "Atlas/CheckPointIcon/icon_cardpiece6.png"},
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
                
