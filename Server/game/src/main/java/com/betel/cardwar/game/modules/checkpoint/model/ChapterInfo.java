package com.betel.cardwar.game.modules.checkpoint.model;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/21
 */
public class ChapterInfo
{
    public int id;
    public List<CheckPoint> checkPoints;

    public JSONObject toRspdJson()
    {
        JSONObject json = new JSONObject();
        json.put("id", id);
        JSONArray array = new JSONArray();
        for (int i = 0; i < checkPoints.size(); i++)
        {
            array.add(checkPoints.get(i).toRspdJson());
        }
        json.put("checkPoints", array);
        return json;
    }
}
