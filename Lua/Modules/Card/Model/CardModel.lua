---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2020-04-12-01:33:50
---

local BaseModel = require("Game.Core.Ioc.BaseModel")
---@class Game.Modules.Card.Model.CardModel : Game.Core.Ioc.BaseModel
---@field cardService Game.Modules.Card.Service.CardService
local CardModel = class("Game.Modules.Card.Model.CardModel",BaseModel)

function CardModel:Ctor()
    
end

return CardModel
