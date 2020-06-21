package com.betel.cardwar.game.modules.checkpoint;

import com.betel.cardwar.game.modules.checkpoint.model.CheckPointInfo;
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

    private static HashMap<Integer, List<CheckPointInfo>> chapterHashMap;
    private static List<CheckPointInfo> checkPointInfos;

    /**
     * 获取章节的关卡列表
     * @param chapter
     * @return
     */
    public static List<CheckPointInfo> getCheckPointInfos(int chapter)
    {
        if(chapterHashMap == null)
        {
            chapterHashMap = new HashMap<>();
            List<CheckPointInfo> allList = getItemInfoList();
            for (int i = 0; i < allList.size(); i++)
            {
                List<CheckPointInfo> list = chapterHashMap.get(allList.get(i).chapter);
                if(list == null)
                {
                    list = new ArrayList<>();
                    chapterHashMap.put(allList.get(i).chapter, list);
                }
                list.add(allList.get(i));
            }
        }
        return chapterHashMap.get(chapter);
    }

    public static List<CheckPointInfo> getItemInfoList()
    {
        if(checkPointInfos == null)
            checkPointInfos = JsonFileUtils.getDataList("/CheckPoint.json", CheckPointInfo.class, JSON_LIST_FIELD);
        return checkPointInfos;
    }

    public static void main(String[] arg)
    {
        ModuleConfig.getCheckPointInfos(0);
    }
}
