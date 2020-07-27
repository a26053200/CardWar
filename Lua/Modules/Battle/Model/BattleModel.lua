---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2019-05-18-23:23:09
---


local BaseModel = require("Game.Core.Ioc.BaseModel")
---@class Game.Modules.Battle.Model.BattleModel : Game.Core.Ioc.BaseModel
---@field battleService Game.Modules.Battle.Service.BattleService
---@field currentContext WorldContext
---@field currCheckPointData CheckPointData     当前关卡数据
---@field battleSceneInfo BattleSceneInfo --战斗场景信息
---@field playerVo Game.Modules.Player.Vo.PlayerVo    当前战斗的玩家
---@field currBattleMode BattleMode
---@field battleResult boolean
---@field currAreaId number
---@field startTime number
---@field checkpointReports table<number, Game.Modules.Battle.Vo.BattleReportVo> pve关卡战报
---@field checkpointReportMap table<string, Game.Modules.Battle.Vo.BattleReportVo> pve关卡战报
---@field isReplayReport boolean 播放战报
local BattleModel = class("BattleModel",BaseModel)

function BattleModel:Ctor()
    self.startTime = 0
end

function BattleModel:Clear()
    self.currentContext = nil
    self.currCheckPointData = nil
    self.battleSceneInfo = nil
    self.playerVo = nil
    self.isEditBattleArrayComplete = false
    self.isReplayReport = false
end

return BattleModel
