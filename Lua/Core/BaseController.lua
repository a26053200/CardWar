---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2018/6/19 18:18
---


---@class ProtocolInfo
---@field command string
---@field modal boolean
---@field server string
---@field fields table<number, string>

local LuaMonoBehaviour = require("Betel.LuaMonoBehaviour")
---@class Game.Core.BaseController : Betel.LuaMonoBehaviour
---@field New fun()
local BaseController = class("Game.Core.BaseController ",LuaMonoBehaviour)

function BaseController:Ctor()
    vmgr:RegisterCtrl(self)
end

function BaseController:OnInit()

end

--Json请求
---@param protocol ProtocolInfo
---@param param table<number, any>
---@param callback Handler
---@param failCallback Handler
function BaseController:Request(protocol, param, callback, failCallback)
    nmgr:SendRequest(protocol, param, callback, failCallback)
end

return BaseController