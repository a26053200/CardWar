package com.betel.cardwar.game.modules;

import com.alibaba.fastjson.JSONArray;
import com.betel.cardwar.game.modules.role.model.RoleLevel;
import com.betel.cardwar.game.utils.JSONArrayUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/14
 */
public class ModuleConfig
{
    private static ArrayList<List<String>> roleName;

    public static List<String> getRoleName(int index)
    {
        if(roleName == null)
        {
            roleName = new ArrayList<>();
            JSONArray array = JSONArrayUtils.getJSONArray("/RoleName.json");
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
            roleLevels = JSONArrayUtils.getDataList("/RoleLevel.json", RoleLevel.class);
        return roleLevels;
    }


}
