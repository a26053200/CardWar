package com.betel.cardwar.game.modules;

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


    private static HashMap<Integer, CardInfo> cardInfoMap;

    public static CardInfo getCardInfo(int cardId)
    {
        if(cardInfoMap == null)
        {
            cardInfoMap = new HashMap<>();
            List<CardInfo> list = JsonFileUtils.getDataList("/Card.json", CardInfo.class, JSON_LIST_FIELD);
            for (int i = 0; i < list.size(); i++)
                cardInfoMap.put(list.get(i).id, list.get(i));
        }
        return cardInfoMap.get(cardId);
    }


    private static List<CardPoolItem> cardPoolItems;
    private static HashMap<String, List<CardPoolItem>> cardPoolItemsMap;

    public static List<CardPoolItem> getCardPoolItems(String poolId)
    {
        if(cardPoolItems == null)
        {
            cardPoolItemsMap = new HashMap<>();
            cardPoolItems = JsonFileUtils.getDataList("/CardPoolItem.json", CardPoolItem.class, JSON_LIST_FIELD);
            for (int i = 0; i < cardPoolItems.size(); i++)
            {
                List<CardPoolItem> poolItemList = cardPoolItemsMap.get(cardPoolItems.get(i).poolId);
                if (poolItemList == null)
                {
                    poolItemList = new ArrayList<>();
                    cardPoolItemsMap.put(cardPoolItems.get(i).poolId, poolItemList);
                }
                poolItemList.add(cardPoolItems.get(i));
            }
        }
        return cardPoolItemsMap.get(poolId);
    }

    private static HashMap<String, CardPool> cardPoolMap;

    public static HashMap<String, CardPool> getCardPoolMap()
    {
        if(cardPoolMap == null)
        {
            cardPoolMap = new HashMap<>();
            List<CardPool> cardPoolList = JsonFileUtils.getDataList("/CardPool.json", CardPool.class, JSON_LIST_FIELD);
            for (int i = 0; i < cardPoolList.size(); i++)
            {
                cardPoolMap.put(cardPoolList.get(i).id, cardPoolList.get(i));
            }
        }
        return cardPoolMap;
    }
    public static CardPool getCardPool(String poolName)
    {
        return getCardPoolMap().get(poolName);
    }
}
