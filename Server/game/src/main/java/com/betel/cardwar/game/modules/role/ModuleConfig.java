package com.betel.cardwar.game.modules.role;

import com.alibaba.fastjson.JSONArray;
import com.betel.cardwar.game.modules.card.model.CardInfo;
import com.betel.cardwar.game.modules.card.model.CardPool;
import com.betel.cardwar.game.modules.card.model.CardPoolItem;
import com.betel.cardwar.game.modules.role.model.RoleLevel;
import com.betel.framework.utils.JsonFileUtils;
import com.betel.utils.JSONArrayUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/14
 */
public class ModuleConfig
{
    private static final String JSON_LIST_FIELD = "list";

    private static ArrayList<List<String>> roleName;

    public static List<String> getRoleName(int index)
    {
        if(roleName == null)
        {
            roleName = new ArrayList<>();
            JSONArray array = JsonFileUtils.getJSONArray("/RoleName.json", JSON_LIST_FIELD);
            roleName.add(JSONArrayUtils.getStringList(array, "name1"));
            roleName.add(JSONArrayUtils.getStringList(array, "name2"));
            roleName.add(JSONArrayUtils.getStringList(array, "name3"));
        }
        return roleName.get(index);
    }

    private static List<RoleLevel> roleLevels;

    public static List<RoleLevel> getRoleLevelList()
    {
        if(roleLevels == null)
            roleLevels = JsonFileUtils.getDataList("/RoleLevel.json", RoleLevel.class, JSON_LIST_FIELD);
        return roleLevels;
    }
}
