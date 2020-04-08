---
--- Created by zhengnan.
--- DateTime: 2017/8/31 21:53
--- 贝塞尔曲线，线性运动
---

---@class Bezier
---@field New fun(gameObject:UnityEngine.GameObject, FlyTagPos:UnityEngine.Vector3, duration:number, updateRot:boolean)
---@field updateRot boolean 是否更新角度
local Bezier = class("Bezier")

function Bezier:Ctor(gameObject, tagPos, duration, updateRot)
    self.gameObject = gameObject
    self.tagPos = tagPos
    self.updateRot = updateRot == nil and true or updateRot
    self.frameNum = self:TimeToFrameNum(duration)
    self.lastPos = self.gameObject.transform.localPosition;
end

---@param cp0 UnityEngine.Vector3
---@param cp1 UnityEngine.Vector3
---@param overCallback fun()
---@param updateHandler fun()
function Bezier:Draw(cp0, cp1, overCallback, updateHandler)
    self.callback = overCallback
    self.updateHandler = updateHandler
    self:Start(cp0, cp1)
end

---@param offsetCp0 UnityEngine.Vector3
---@param offsetCp1 UnityEngine.Vector3
---@param overCallback fun()
---@param updateHandler fun()
function Bezier:DrawOffset(offsetCp0, offsetCp1, overCallback, updateHandler)
    self.callback = overCallback
    self.updateHandler = updateHandler
    local sp = self.lastPos
    local cp0 = Vector3.New(sp.x + offsetCp0.x, sp.y + offsetCp0.y, sp.z)
    local cp1 = Vector3.New(sp.x + offsetCp1.x, sp.y + offsetCp1.y, sp.z)
    self:Start(cp0, cp1)
end

function Bezier:Start(cp0, cp1)
    -- 贝塞尔路径
    self.bezierPath = BezierUtils.GetBezierPointPath(self.lastPos, cp0, cp1, self.tagPos, self.frameNum)
    self.bezierIndex = 1;
    self.bezierLen = #self.bezierPath;

    AddEventListener(Stage, Event.FIXED_UPDATE, self.FixedUpdate, self)
end

--- 时间转帧数
---@param time @ 秒
---@return number
function Bezier:TimeToFrameNum(time)
    return math.floor(time * Application.targetFrameRate + 0.5)
end

function Bezier:FixedUpdate()
    -- 贝塞尔曲线飞行
    if self.bezierIndex >= 1 then
        self.gameObject.transform.localPosition = self.bezierPath[self.bezierIndex];
        self.bezierIndex = self.bezierIndex + 1;
        --log("bezierPath fly "..self.bezierIndex)
        if self.updateRot then
            local dir = Vector3.Sub(self.gameObject.transform.localPosition, self.lastPos)
            local tan = dir.y / dir.x;
            tan = Mathf.Atan(tan);
            tan = 180 / Mathf.PI * tan + 90;
            self.gameObject.transform.localEulerAngles = Vector3.New(0, 0, tan);
        end
        --log("bezierPath fly z "..dir.z)
        self.lastPos = self.gameObject.transform.localPosition;
        if self.bezierIndex >= self.bezierLen then
            self.bezierIndex = 0;
            RemoveEventListener(Stage, Event.FIXED_UPDATE, self.FixedUpdate, self)
            --destroy(self.behaviour)
            --self.behaviour = nil

            if self.callback then
                self.callback()
            end
        else
            if self.updateHandler then
                self.updateHandler()
            end
        end
    end
end

function Bezier:Dispose()
    RemoveEventListener(Stage, Event.FIXED_UPDATE, self.FixedUpdate, self)
end

return Bezier