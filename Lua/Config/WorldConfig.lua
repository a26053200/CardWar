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
