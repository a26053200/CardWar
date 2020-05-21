---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2019/5/25 0:29
---

local BaseBehavior = require('Game.Modules.Common.Behavior.BaseBehavior')

---@class Game.Modules.Battle.Behaviors.AutoMove : Game.Modules.Common.Behavior.BaseBehavior
---@field New fun() : Game.Modules.Battle.Behaviors.AutoMove
---@field areaInfo AreaInfo
---@field avatar Game.Modules.World.Items.Avatar
---@field grid AStar.Grid
---@field overCallback Handler
---@field stepCallback Handler
---@field pathQueue List
---@field lastDistance number 上一次距离目标点距离
local AutoMove = class("Game.Modules.Battle.Behaviors.AutoMove",BaseBehavior)

---@param avatar Game.Modules.World.Items.Avatar
function AutoMove:Ctor(avatar)
    AutoMove.super.Ctor(self, avatar.gameObject)
    self.avatar = avatar
    self.delta = FRAME_TIME * self.avatar.avatarInfo.moveSpeed

    self.aStar = AStar.PathRequestManager
    local aStarObj = vmgr.scene.currSubScene:GetRootObjByName("A*")
    self.grid = aStarObj:GetComponent(typeof(AStar.Grid))
    self.waves = {}
end

function AutoMove:SmoothMove(destPos, overCallback, stepCallback)
    self:DoPathFound(destPos, true, overCallback, stepCallback)
end

function AutoMove:Move(destPos, overCallback, stepCallback)
    self:DoPathFound(destPos, false, overCallback, stepCallback)
end

--只移动一步
function AutoMove:MoveStep(destPos, overCallback, stepCallback)
    self.destPos = destPos
    self.overCallback = overCallback
    self.stepCallback = stepCallback
    self.aStar.RequestPath(self.avatar.transform.position, destPos, 5, 10, false,function(path)
        self.lookPoints = path.lookPoints
        self:OnPathFound({path.lookPoints[0]})
        self.avatar.isMoving = true
        AddEventListener(Event.Update, self.Update, self)
    end,function()
        if self.overCallback then
            self.overCallback:Execute(false)
        end
    end)
end

function AutoMove:MoveDirect(destPos, overCallback, stepCallback)
    self.destPos = destPos
    self.overCallback = overCallback
    self.stepCallback = stepCallback
    self.pathQueue = List.New()
    self.pathQueue:UnShift(destPos)
    self.avatar.isMoving = true
    AddEventListener(Event.Update, self.Update, self)
end

function AutoMove:DoPathFound(destPos, smooth, overCallback, stepCallback)
    self.destPos = destPos
    self.overCallback = overCallback
    self.stepCallback = stepCallback
    if self:IsArrive(destPos) then
        if self.overCallback then
            self.overCallback:Execute(true)
        end
    else
        self.aStar.RequestPath(self.avatar.transform.position, destPos, 5, 10, smooth,function(path)
            self.lookPoints = path.lookPoints
            self:OnPathFound(Tool.ToLuaArray(path.lookPoints))
        end,function()
            if self.overCallback then
                self.overCallback:Execute(false)
            end
        end)
    end
end

---@param path AStar.Path
function AutoMove:OnPathFound(path)
    self.pathQueue = List.New(path)
    --self.pathQueue:UnShift(self.avatar.transform.position)
    self.avatar.isMoving = true
    AddEventListener(Event.Update, self.Update, self)
end

function AutoMove:Update()
    if isNull(self.gameObject) then
        return
    end
    local nextPos = self.pathQueue:Peek()
    if nextPos == nil then
        --print(self.gameObject.name .. " - nextPos nil")
        return
    end
    if not self:IsArrive(nextPos) then
        self.avatar.transform.forward = (nextPos - self.avatar.transform.position).normalized
        self.avatar.transform.position = Vector3.MoveTowards(self.avatar.transform.position, nextPos, self.delta)
        self.avatar:UpdateNode()
    else
        self:NextPos()
    end
end

function AutoMove:NextPos()
    if self.pathQueue:Size() == 1 then
        self.avatar.transform.position = self.pathQueue:Shift()
        self.avatar:UpdateNode()
        if self.overCallback then
            self.overCallback:Execute(true)
        end
        --print(self.gameObject.name .. " - AutoMove Stop")
        self:Stop()
    else
        local currPos = self.pathQueue[1]
        local nextPos = self.pathQueue[2]
        self.pathQueue:Shift()
        self.avatar.transform.forward = (nextPos - currPos).normalized
    end
end

---@param nextPos UnityEngine.Vector3
function AutoMove:IsArrive(nextPos)
    --local currNode = self.grid:NodeFromWorldPoint(self.avatar.transform.position)
    --local nextNode = self.grid:NodeFromWorldPoint(nextPos)
    --if currNode.worldPosition == nextNode.worldPosition then
    --    return true
    --else
    --    return false
    --end
    local distance = Vector3.Distance(self.avatar.transform.position, nextPos)
    if distance < self.delta then
        return true
    else
        return false
    end
end

function AutoMove:Stop()
    self.avatar.isMoving = false
    self.overCallback = nil
    self.stepCallback = nil
    RemoveEventListener(Event.Update, self.Update, self)
end

function AutoMove:Dispose()
    AutoMove.super.Dispose(self)
    self:Stop()
end


return AutoMove