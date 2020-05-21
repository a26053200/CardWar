package com.betel.framework.event;

import java.util.HashMap;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/14
 */
public class EventDispatcher
{
    private EventTrigger _eventTrigger;
    private HashMap<String, EventDelegate> _eventMap;
    public EventDispatcher()
    {
        _eventTrigger = new EventTrigger();
    }
    public EventDispatcher(EventTrigger eventDispatch)
    {
        _eventTrigger = eventDispatch;
    }
    public void dispatchEvent(EventObject evt)
    {
        _eventTrigger.dispatchEvent(evt);
    }
    public void addEventListener(String eventType, EventDelegate eventObj)
    {
        if (_eventMap == null)
            _eventMap = new HashMap<String, EventDelegate>();
        if (_eventMap.containsKey(eventType))
        {
            System.err.println("事件重复注册" + eventType);
        }
        else
        {
            _eventMap.put(eventType, eventObj);
            _eventTrigger.addEventListener(eventType, eventObj);
        }
    }
    public void removeEeventListener(String eventType, EventDelegate eventObj)
    {
        if (_eventMap == null)
            return;
        if (_eventMap.containsKey(eventType))
        {
            _eventTrigger.removeEventListener(eventType, eventObj);
            _eventMap.remove(eventType);
        }
    }
    public void removeAllEvent()
    {
        if (_eventMap == null)
            return;
        _eventMap.forEach((eventTypes, eventDelegate) -> {
            _eventTrigger.removeEventListener(eventTypes, eventDelegate);
        });
        _eventMap.clear();
        _eventMap = null;
    }
}
