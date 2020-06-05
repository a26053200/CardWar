package com.betel.framework.utils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.betel.utils.JSONArrayUtils;

import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/30
 */
public class JsonFileUtils
{
    public static JSONArray getJSONArray(String file, String listField)
    {
        String path = JsonFileUtils.class.getResource(file).getPath();
        JSONObject json = JSONArrayUtils.getJsonObject(path);
        JSONArray array = json.getJSONArray(listField);
        return array;
    }
    public static <T> List<T> getDataList(String file, Class<T> clazz, String listField)
    {
        String path = JsonFileUtils.class.getResource(file).getPath();
        return JSONArrayUtils.getDataList(path, clazz, listField);
    }
}
