package com.betel.framework.event;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/15
 */
public class EventTrigger
{
    protected HashMap<String, ArrayList<EventDelegate>> captureListeners = null;

    protected HashMap<String, ArrayList<EventDelegate>> bubbleListeners = null;

    protected EventTrigger _parent;

    public void addEventListener(String types, EventDelegate listener)
    {
        addEventListener(types, listener, false,0,false);
    }
    public void addEventListener(String types, EventDelegate listener, boolean useCapture, int priority, boolean useWeakReference)
    {
        HashMap<String, ArrayList<EventDelegate>> listeners = null;

        if (listener == null)
        {
            System.err.println("Parameter listener must be non-null.");
            return;
        }
        if (useCapture)
        {
            if (captureListeners == null) captureListeners = new HashMap<String, ArrayList<EventDelegate>>();
            listeners = captureListeners;
        }
        else
        {
            if (bubbleListeners == null) bubbleListeners = new HashMap<String, ArrayList<EventDelegate>>();
            listeners = bubbleListeners;
        }
        ArrayList<EventDelegate> vector = null;
        if (listeners.containsKey(types))
        {
            vector = listeners.get(types);
        }
        if (vector == null)
        {
            vector = new ArrayList<EventDelegate>();
            listeners.put(types, vector);
        }
        if (!vector.contains(listener))
        {
            vector.add(listener);
        }
    }

    public void removeEventListener(String types, EventDelegate listener)
    {
        removeEventListener(types, listener, false);
    }
    public void removeEventListener(String types, EventDelegate listener, boolean useCapture)
    {
        if (listener == null)
        {
            System.err.println("Parameter listener must be non-null.");
            return;
        }
        HashMap<String, ArrayList<EventDelegate>> listeners = useCapture ? captureListeners : bubbleListeners;
        if (listeners != null)
        {
            ArrayList<EventDelegate> vector = listeners.getOrDefault(types, null);
            if (vector != null)
            {
                int i = vector.indexOf(listener);
                if (i >= 0)
                {
                    vector.remove(listener);

                    if (vector.size() == 0)
                        listeners.remove(types);
                    listeners.forEach((key, list) -> {
                        if (key == null)
                        {
                            if (listeners == captureListeners)
                            {
                                captureListeners = null;
                            }
                            else
                            {
                                bubbleListeners = null;
                            }
                        }
                    });
                }
            }
        }

    }

    public boolean hasEventListener(String types)
    {
        return (captureListeners != null && captureListeners.containsKey(types)) || (bubbleListeners != null && bubbleListeners.containsKey(types));
    }

    public boolean willTrigger(String types)
    {
        for (EventTrigger _object = this; _object != null; _object = _object._parent)
        {
            if ((_object.captureListeners != null && _object.captureListeners.containsKey(types)) || (_object.bubbleListeners != null && _object.bubbleListeners.containsKey(types)))
                return true;
        }
        return false;
    }

    public boolean dispatchEvent(EventObject evt)
    {
        if (evt == null)
        {
            System.err.println("Parameter EventObject must be non-null.");
            return false;
        }
        EventObject event3D = evt;
        if (event3D != null)
        {
            event3D.setTarget(this);
        }
        ArrayList<EventTrigger> branch = new ArrayList<EventTrigger>();
        int branchLength = 0;
        EventTrigger _object;
        int i, j = 0;
        int length;
        ArrayList<EventDelegate> vector;
        ArrayList<EventDelegate> functions;
        for (_object = this; _object != null; _object = _object._parent)
        {
            branch.add(_object);
            branchLength++;
        }
        for (i = branchLength - 1; i > 0; i--)
        {
            _object = branch.get(i);
            if (event3D != null)
            {
                event3D.setCurrentTarget(_object);
                event3D.setEventPhase(EventPhase.CAPTURING_PHASE);
            }
            if (_object.captureListeners != null)
            {
                vector = _object.captureListeners.getOrDefault(evt.getTypes(), null);
                if (vector != null)
                {
                    length = vector.size();
                    functions = new ArrayList<EventDelegate>();
                    for (j = 0; j < length; j++) functions.set(j, vector.get(j));
                    for (j = 0; j < length; j++) functions.get(j).invoke(evt);
                }
            }
        }
        if (event3D != null)
        {
            event3D.setEventPhase(EventPhase.AT_TARGET);
        }
        for (i = 0; i < branchLength; i++)
        {
            _object = branch.get(i);
            if (event3D != null)
            {
                event3D.setCurrentTarget(_object);
                if (i > 0)
                {
                    event3D.setEventPhase(EventPhase.BUBBLING_PHASE);
                }
            }
            if (_object.bubbleListeners != null)
            {
                vector = _object.bubbleListeners.getOrDefault(evt.getTypes(), null);
                if (vector != null)
                {
                    length = vector.size();
                    functions = new ArrayList<EventDelegate>();
                    for (j = 0; j < length; j++) functions.add(vector.get(j));
                    for (j = 0; j < length; j++) functions.get(j).invoke(evt);
                }
            }
            if (!event3D.isBubbles()) break;
        }
        return true;
    }
}
