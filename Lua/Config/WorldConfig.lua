WorldConfig = {}

WorldConfig.TempA = {
    debugName = "临时场景A",
    level = "TempA",
    levelUrl = "",
}
WorldConfig.TempB = {
    debugName = "临时场景B",
    level = "TempB",
    levelUrl = "",
}
WorldConfig.Loading = {
    debugName = "加载场景",
    level = "Loading",
    sceneName = "Loading",
    levelUrl = "",
}
WorldConfig.Login = {
    debugName = "登陆场景",
    level = "Temp",
    sceneName = "Login",
    levelUrl = "",
    needLoading = false
}
WorldConfig.World = {
    debugName = "世界根场景",
    level = "World",
    sceneName = "World",
    levelUrl = "Scenes/World.unity",
    needLoading = true,
    subLevels = {
        Lobby =
        {
            sceneClass = "Game.Modules.World.Scenes.LobbyScene",
            level = "Lobby",
            levelUrl = "Scenes/Lobby.unity",
        },
        battle1 =
          {
              sceneClass = "Game.Modules.World.Scenes.BattleScene",
              level = "pve_research_1_UH",
              levelUrl = "Scenes/pve_research_1_UH.unity",
          },
    },
}
