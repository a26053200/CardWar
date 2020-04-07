---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2018/6/12 10:37
---

local IocContext = require("Core.Ioc.IocContext")
local ModelContext = class("ModelContext",IocContext)

function ModelContext:Ctor(binder)
    self.binder = binder
end

function ModelContext:Launch()
    --TODO
	self.binder:Bind(require("Module.AdventureEvent.Model.AdventureEventModel")):ToSingleton()
	self.binder:Bind(require("Module.ArrangeHero.Model.ArrangeHeroModel")):ToSingleton()
	self.binder:Bind(require("Module.Awake.Model.AwakeModel")):ToSingleton()
	self.binder:Bind(require("Module.Battle.Model.BattleModel")):ToSingleton()
	self.binder:Bind(require("Module.BattleRstTest.Model.BattleRstTestModel")):ToSingleton()
	self.binder:Bind(require("Module.BossChallenge.Model.BossChallengeModel")):ToSingleton()
	self.binder:Bind(require("Module.BossInfo.Model.BossInfoModel")):ToSingleton()
	self.binder:Bind(require("Module.BossProgress.Model.BossProgressModel")):ToSingleton()
	self.binder:Bind(require("Module.BossRstRank.Model.BossRstRankModel")):ToSingleton()
	self.binder:Bind(require("Module.Card.Model.CardModel")):ToSingleton()
	self.binder:Bind(require("Module.Chapter.Model.ChapterModel")):ToSingleton()
	self.binder:Bind(require("Module.CheckPoint.Model.CheckPointModel")):ToSingleton()
	self.binder:Bind(require("Module.Idle.Model.IdleModel")):ToSingleton()
	self.binder:Bind(require("Module.Item.Model.ItemModel")):ToSingleton()
	self.binder:Bind(require("Module.Loading.Model.LoadingModel")):ToSingleton()
	self.binder:Bind(require("Module.Login.Model.LoginModel")):ToSingleton()
	self.binder:Bind(require("Module.MiniScene.Model.MiniSceneModel")):ToSingleton()
	self.binder:Bind(require("Module.Mood.Model.MoodModel")):ToSingleton()
	self.binder:Bind(require("Module.Player.Model.PlayerModel")):ToSingleton()
	self.binder:Bind(require("Module.Plot.Model.PlotModel")):ToSingleton()
	self.binder:Bind(require("Module.World.Model.WorldModel")):ToSingleton()
    --TODO
end

return ModelContext