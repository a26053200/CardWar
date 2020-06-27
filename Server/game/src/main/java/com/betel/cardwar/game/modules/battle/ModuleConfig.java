package com.betel.cardwar.game.modules.battle;

import com.betel.cardwar.game.modules.battle.model.BattleUnitInfo;
import com.betel.cardwar.game.modules.card.model.CardInfo;
import com.betel.cardwar.game.modules.card.model.CardPool;
import com.betel.cardwar.game.modules.card.model.CardPoolItem;
import com.betel.cardwar.game.modules.checkpoint.model.CheckPointInfo;
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

    private static HashMap<String, BattleUnitInfo> battleUnitInfoMap;
    private static List<BattleUnitInfo> battleUnitInfos;

    public static BattleUnitInfo getBattleUnitInfo(String id)
    {
        if(battleUnitInfoMap == null)
        {
            battleUnitInfoMap = new HashMap<>();
            List<BattleUnitInfo> list = getBattleUnitInfos();
            for (int i = 0; i < list.size(); i++)
                battleUnitInfoMap.put(list.get(i).id, list.get(i));
        }
        return battleUnitInfoMap.get(id);
    }
    public static List<BattleUnitInfo> getBattleUnitInfos()
    {
        if(battleUnitInfos == null)
            battleUnitInfos = JsonFileUtils.getDataList("/BattleUnit.json", BattleUnitInfo.class, JSON_LIST_FIELD);
        return battleUnitInfos;
    }

    private static HashMap<String, CheckPointInfo> checkPointInfoHashMap;

    public static CheckPointInfo getCheckPointInfo(String checkPointId)
    {
        if(checkPointInfoHashMap == null)
        {
            checkPointInfoHashMap = new HashMap<>();
            List<CheckPointInfo> list = JsonFileUtils.getDataList("/CheckPoint.json", CheckPointInfo.class, JSON_LIST_FIELD);
            for (int i = 0; i < list.size(); i++)
                checkPointInfoHashMap.put(list.get(i).id, list.get(i));
        }
        return checkPointInfoHashMap.get(checkPointId);
    }
}
