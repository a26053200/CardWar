package com.betel.framework.event;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/15
 */
public class EventObject
{
    private EventTrigger target;
    private int eventPhase;
    private EventTrigger currentTarget;
    private boolean bubbles;
    private boolean cancelable;
    private String types;

    public EventObject(String types, boolean bubbles, boolean cancelable)
    {
        this.types = types;
        this.bubbles = bubbles;
        this.cancelable = cancelable;
    }
    public EventObject(String types)
    {
        this.types = types;
        this.bubbles = false;
        this.cancelable = false;
    }

    public EventTrigger getTarget()
    {
        return target;
    }

    public void setTarget(EventTrigger target)
    {
        this.target = target;
    }

    public int getEventPhase()
    {
        return eventPhase;
    }

    public void setEventPhase(int eventPhase)
    {
        this.eventPhase = eventPhase;
    }

    public EventTrigger getCurrentTarget()
    {
        return currentTarget;
    }

    public void setCurrentTarget(EventTrigger currentTarget)
    {
        this.currentTarget = currentTarget;
    }

    public boolean isBubbles()
    {
        return bubbles;
    }

    public boolean isCancelable()
    {
        return cancelable;
    }

    public String getTypes()
    {
        return types;
    }

}
