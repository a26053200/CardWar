---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2018/6/19 18:18
---

---@class Response
---@field server string
---@field data table
---@field action string
---@field state SessionState

local LuaObject = require('Betel.LuaObject')
---@class Game.Core.Ioc.BaseService : Betel.LuaObject
local BaseService = class("BaseService", LuaObject)

function BaseService:Ctor()

end

--Http请求
---@param action Action
---@param params table
---@param callback fun()
function BaseService:HttpRequest(action, params, callback)
    NetModal.Show()
    ---@param response Response
    nmgr:HttpRqst(action, params, function(response)
        NetModal.Hide()
        if response.state == SessionState.Success then
            callback(response.data)
        elseif response.state == SessionState.Fail then
            --Tips.Show(response.data.msg)
        else
            logError("Unknown session error:" .. response.state)
        end
        if response and response.data and response.data.msg then
            Tips.Show(response.data.msg)
        end
    end)
end

--Http请求
---@param action Action
---@param params table
---@param callback fun()
function BaseService:HttpPost(action, params, callback)
    NetModal.Show()
    ---@param response Response
    nmgr:HttpPost(action, params, function(response)
        NetModal.Hide()
        if response.state == SessionState.Success then
            callback(response.data)
        elseif response.state == SessionState.Fail then
            --Tips.Show(response.data.msg)
        else
            logError("Unknown session error:" .. response.state)
        end
        if response and response.data and response.data.msg then
            Tips.Show(response.data.msg)
        end
    end)
end

--Json请求
---@param action table
---@param param table
---@param callback fun()
---@param failCallback fun()
function BaseService:JsonRequest(action, param, callback, failCallback)
    --nmgr:Request(action, param, function(response)
    --    if response.state == 0 then
    --        if callback then
    --            callback(response.data)
    --        end
    --    else
    --        if response.data.msg then
    --            logError(response.data.msg)
    --            Tips.Show(response.data.msg)
    --        end
    --        if failCallback then
    --            failCallback(response)
    --        end
    --    end
    --end)
end

--Json请求
---@param protocol ProtocolInfo
---@param param table<number, any>
---@param callback Handler
---@param failCallback Handler
function BaseService:Request(protocol, param, callback, failCallback)
    nmgr:SendRequest(protocol, param, callback, failCallback)
end

return BaseService