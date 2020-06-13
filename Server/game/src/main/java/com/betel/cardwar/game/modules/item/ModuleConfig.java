package com.betel.cardwar.game.modules.item;

import com.betel.cardwar.game.modules.card.model.CardInfo;
import com.betel.cardwar.game.modules.card.model.CardPool;
import com.betel.cardwar.game.modules.card.model.CardPoolItem;
import com.betel.cardwar.game.modules.item.model.ItemInfo;
import com.betel.framework.utils.JsonFileUtils;

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

    private static HashMap<Integer, ItemInfo> itemInfoMap;
    private static List<ItemInfo> itemInfoList;

    public static ItemInfo getItemInfo(int itemId)
    {
        if(itemInfoMap == null)
        {
            itemInfoMap = new HashMap<>();
            List<ItemInfo> list = getItemInfoList();
            for (int i = 0; i < list.size(); i++)
                itemInfoMap.put(list.get(i).id, list.get(i));
        }
        return itemInfoMap.get(itemId);
    }

    public static List<ItemInfo> getItemInfoList()
    {
        if(itemInfoList == null)
            itemInfoList = JsonFileUtils.getDataList("/Item.json", ItemInfo.class, JSON_LIST_FIELD);
        return itemInfoList;
    }
}
