---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2020-04-13-23:15:23
---

local CardVo = require("Game.Modules.Card.Vo.CardVo")
local PlayerVo = require("Game.Modules.Player.Vo.PlayerVo")
local BaseModel = require("Game.Core.Ioc.BaseModel")
---@class Game.Modules.Player.Model.PlayerModel : Game.Core.Ioc.BaseModel
---@field playerService Game.Modules.Player.Service.PlayerService
---@field myPlayerVo Game.Modules.Player.Vo.PlayerVo
local PlayerModel = class("PlayerModel",BaseModel)

function PlayerModel:Ctor()
    --self.myPlayerVo = PlayerVo.New()
    --self.myPlayerVo.id = 1
    --self.myPlayerVo.nickName = "玩家"
    --self.myPlayerVo.cards = {
    --    CardVo.New(100001),
    --    CardVo.New(100002),
    --    CardVo.New(100003),
    --    CardVo.New(100004),
    --    CardVo.New(100005),
    --    CardVo.New(100006),
    --    CardVo.New(100007),
    --    CardVo.New(100008),
    --    CardVo.New(100009),
    --}
    --for i = 1, #self.myPlayerVo.cards do
    --    self.myPlayerVo.cards[i].state = CardState.GridBattle
    --    self.myPlayerVo.cards[i].layoutIndex = i
    --end
    --self.players = {}
    --table.insert(self.players, self.myPlayerVo)
    --self:InitInTeamHeroes()
end

return PlayerModel
