--
-- 鼠标指针或手指拖动相关事件
-- 可以在任何 gameObject 上抛出
-- 2017/11/23
-- Author LOLO
--

local Event = require("Betel.Events.Event")
---@class DragDropEvent : Core.Events.Event
---@field data UnityEngine.EventSystems.DragDropEventData @ 指针事件附带的数据
local DragDropEvent = class("DragDropEvent", Event)

function DragDropEvent:Ctor(type, data)
    DragDropEvent.super.Ctor(self, type, data)
end


--=------------------------------[ static ]------------------------------=--

--- 鼠标指针/手势按下进入对象
DragDropEvent.BEGIN_DRAG = "DragDropEvent_BeginDrag"

--- 鼠标指针/手势拖动进入对象
DragDropEvent.DRAG = "DragDropEvent_Drag"

--- 鼠标指针/手势抬起进入对象
DragDropEvent.END_DRAG = "DragDropEvent_EndDrag"

--
--local event = DragDropEvent.New()



--=----------------------------------------------------------------------=--

return DragDropEvent