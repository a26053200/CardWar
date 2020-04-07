---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2018/6/12 10:37
---

local IocContext = require("Core.Ioc.IocContext")
local ServiceContext = class("ServiceContext",IocContext)

function ServiceContext:Ctor(binder)
    self.binder = binder
end

function ServiceContext:Launch()
    --TODO
	self.binder:Bind(require("Module.AdventureEvent.Service.AdventureEventService")):ToSingleton()
	self.binder:Bind(require("Module.Battle.Service.BattleService")):ToSingleton()
	self.binder:Bind(require("Module.BossInfo.Service.BossInfoService")):ToSingleton()
	self.binder:Bind(require("Module.BossProgress.Service.BossProgressService")):ToSingleton()
	self.binder:Bind(require("Module.BossRstRank.Service.BossRstRankService")):ToSingleton()
	self.binder:Bind(require("Module.Card.Service.CardService")):ToSingleton()
	self.binder:Bind(require("Module.Chapter.Service.ChapterService")):ToSingleton()
	self.binder:Bind(require("Module.CheckPoint.Service.CheckPointService")):ToSingleton()
	self.binder:Bind(require("Module.Idle.Service.IdleService")):ToSingleton()
	self.binder:Bind(require("Module.Item.Service.ItemService")):ToSingleton()
	self.binder:Bind(require("Module.Loading.Service.LoadingService")):ToSingleton()
	self.binder:Bind(require("Module.Login.Service.LoginService")):ToSingleton()
	self.binder:Bind(require("Module.MiniScene.Service.MiniSceneService")):ToSingleton()
	self.binder:Bind(require("Module.Player.Service.PlayerService")):ToSingleton()
	self.binder:Bind(require("Module.World.Service.WorldService")):ToSingleton()
    --TODO
end

return ServiceContext
