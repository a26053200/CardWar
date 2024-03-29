---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2020-06-16-22:50:01
---

local BaseMediator = require("Game.Core.Ioc.BaseMediator")
---@class Game.Modules.Adventure.View.AdventureMdr : Game.Core.Ioc.BaseMediator
---@field adventureModel Game.Modules.Adventure.Model.AdventureModel
---@field adventureService Game.Modules.Adventure.Service.AdventureService
local AdventureMdr = class("Game.Modules.Adventure.View.AdventureMdr",BaseMediator)

function AdventureMdr:OnInit()
    
end

function AdventureMdr:On_Click_BtnTrunk()
    --主线关卡
    navigation:Push(ViewConfig.CheckPoint)
end

function AdventureMdr:On_Click_BtnDaily()
    --日常关卡
end

function AdventureMdr:On_Click_BtnChallenge()
    --挑战关卡
end

return AdventureMdr
