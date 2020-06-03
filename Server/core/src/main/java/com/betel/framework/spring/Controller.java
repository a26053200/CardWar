package com.betel.framework.spring;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.asd.interfaces.IVo;
import com.betel.consts.FieldName;
import com.betel.servers.action.ImplAction;
import com.betel.session.Session;
import com.betel.spring.IRedisService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/2
 */
public abstract class Controller
{
    final static Logger logger = LogManager.getLogger(Controller.class);

    protected ImplAction action;
    protected IRedisService service;
    protected JSONObject rspdJson;

    public Controller(ImplAction action, IRedisService service)
    {
        this.action = action;
        this.service = service;
        rspdJson = new JSONObject();
    }

    public void newRspd(Session session)
    {
        if(!rspdJson.isEmpty())
        {
            logger.error("There is old json has not respond to the client!");
            rspdJson.clear();
        }
//        return true;
    }

    public void append(String key, Object obj)
    {
        rspdJson.put(key, JSON.toJSON(obj));
    }

    public void append(String key, String json)
    {
        rspdJson.put(key, json);
    }


    public void append(String key, double json)
    {
        rspdJson.put(key, json);
    }

    public void append(String key, int json)
    {
        rspdJson.put(key, json);
    }

    public void append(String key, Enum json)
    {
        rspdJson.put(key, json);
    }

    public void send2client(Session session)
    {
        action.rspdClient(session, rspdJson);
        rspdJson.clear();
    }

    protected void rspdMessage(Session session, String msg)
    {
        JSONObject rspdJson = new JSONObject();
        rspdJson.put(FieldName.MSG, msg);
        this.action.rspdClient(session, rspdJson);
    }
}
