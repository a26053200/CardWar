---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2020-06-27-23:51:44
---

local BaseMediator = require("Game.Core.Ioc.BaseMediator")
---@class Game.Modules.Battle.View.PveBattleInfoMdr : Game.Core.Ioc.BaseMediator
---@field battleModel Game.Modules.Battle.Model.BattleModel
---@field battleService Game.Modules.Battle.Service.BattleService
local PveBattleInfoMdr = class("Game.Modules.Battle.View.PveBattleInfoMdr",BaseMediator)

function PveBattleInfoMdr:OnInit()
    
end

return PveBattleInfoMdr