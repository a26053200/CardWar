package com.betel.cardwar.game.utils;

import com.alibaba.fastjson.JSONArray;

import java.lang.reflect.Array;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/7/13
 */
public class JSONUtils
{
    public static <T> T[] getDataList(JSONArray array, Class<T> clazz) {
        T[] list = (T[]) Array.newInstance(clazz, array.size());
        for(int i = 0; i < array.size(); ++i) {
            list[i] = array.getJSONObject(i).toJavaObject(clazz);
        }
        return list;
    }
}
