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

local LuaMonoBehaviour = require("Core.LuaMonoBehaviour")
---@class Game.Core.BaseCommand : Core.LuaMonoBehaviour
---@field New fun()
local BaseCommand = class("Game.Core.BaseCommand ",LuaMonoBehaviour)


function BaseCommand:Ctor()

end

function BaseCommand:OnInit()

end

--Json请求
---@param protocol ProtocolInfo
---@param param table<number, any>
---@param callback Handler
---@param failCallback Handler
function BaseCommand:Request(protocol, param, callback, failCallback)
    nmgr:SendRequest(protocol, param, callback, failCallback)
end

return BaseCommand