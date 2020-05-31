package com.betel.cardwar.game.utils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.betel.framework.utils.JsonFileUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/30
 */
public class JSONArrayUtils
{
    private static final String LIST = "list";

    public static List<String> getStringList(JSONArray array, String field)
    {
        ArrayList<String> list = new ArrayList<>();
        for (int i = 0; i < array.size() ; i++)
        {
            list.add(array.getJSONObject(i).getString(field));
        }
        return list;
    }

    public static JSONArray getJSONArray(String file)
    {
        JSONObject json = JsonFileUtils.getJsonObject(file);
        JSONArray array = json.getJSONArray(LIST);
        return array;
    }

    public static <T> List<T> getDataList(String file, Class<T> clazz)
    {
        List<T> list = new ArrayList<>();
        JSONArray array = getJSONArray(file);
        for (int i = 0; i < array.size(); i++)
        {
            list.add(i, array.getJSONObject(i).toJavaObject(clazz));
        }
        return list;
    }
}
