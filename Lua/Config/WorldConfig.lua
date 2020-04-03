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
WorldConfig.GuideScene = {
    debugName = "新手引导场景",
    level = "GuideNewbie",
    sceneName = "GuideNewbie",
    levelUrl = "Scenes/GuideNewbie.unity",
    needLoading = true
}
WorldConfig.Lobby = {
    debugName = "游戏大厅",
    level = "Lobby",
    sceneName = "Lobby",
    levelUrl = "Scenes/Lobby.unity",
    needLoading = false
}
WorldConfig.Room_HJ = {
    debugName = "红尖",
    level = "Room_HJ",
    sceneName = "Room_HJ",
    levelUrl = "Scenes/Room_HJ.unity",
    needLoading = true
}
WorldConfig.Battle = {
    debugName = "Battle",
    level = "Battle",
    sceneName = "Battle",
    levelUrl = "Scenes/Battle.unity",
    needLoading = true,
    subLevels = {
      [1] =
      {
          level = "Stage1",
          levelUrl = "Scenes/Stage1.unity",
      },
    },
    needLoading = true
}
