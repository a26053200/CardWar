---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2018/6/29 23:45
---


local LuaObject = require("Core.LuaObject")
---@class Game.Manager.ViewInfo : Core.LuaObject
---@field name string
---@field prefab string
---@field module string
---@field status ViewStatus
local ViewInfo = class("Game.Manager.ViewInfo",LuaObject)

function ViewInfo:Ctor()
    self.name = ""
    self.prefab = ""
end

return ViewInfo