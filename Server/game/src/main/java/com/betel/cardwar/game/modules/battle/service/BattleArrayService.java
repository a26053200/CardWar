package com.betel.cardwar.game.modules.battle.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.BaseService;
import com.betel.asd.RedisDao;
import com.betel.cardwar.game.consts.Field;
import com.betel.cardwar.game.modules.battle.model.BattleArray;
import com.betel.cardwar.game.modules.battle.model.BattleArrayDao;
import com.betel.cardwar.game.modules.checkpoint.model.CheckPoint;
import com.betel.session.Session;
import com.betel.utils.IdGenerator;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/24
 */
public class BattleArrayService extends BaseService<BattleArray>
{
    final static Logger logger = LogManager.getLogger(BattleArrayService.class);

    @Autowired
    protected BattleArrayDao dao;
    @Override
    public RedisDao<BattleArray> getDao()
    {
        return dao;
    }
    private HashMap<String, List<BattleArray>> battleArrayHashMap = new HashMap<>();

    //获取战斗编组
    private void getBattleArray(Session session)
    {
        String roleId       = session.getRecvJson().getString(Field.ROLE_ID);
        int battleType      = session.getRecvJson().getIntValue(Field.BATTLE_TYPE);
        BattleArray battleArray = getCacheBattleArray(roleId, battleType);
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.BATTLE_ARRAY, battleArray == null ? "" : battleArray.getCardIds());
        rspdClient(session, sendJson);
    }

    private void saveBattleArray(Session session)
    {
        String roleId       = session.getRecvJson().getString(Field.ROLE_ID);
        int battleType      = session.getRecvJson().getIntValue(Field.BATTLE_TYPE);
        JSONArray cardIds   = session.getRecvJson().getJSONArray(Field.BATTLE_ARRAY);
        String[] a = new String[cardIds.size()];
        BattleArray battleArray = getCacheBattleArray(roleId, battleType);
        JSONObject sendJson = new JSONObject();
        if(battleArray == null)
        {
            battleArray = new BattleArray();
            battleArray.setId(Long.toString(IdGenerator.getInstance().nextId()));
            battleArray.setVid(roleId);
            battleArray.setBattleType(battleType);
            battleArray.setCardIds(cardIds.toArray(a));
            dao.addEntity(battleArray);
            battleArrayHashMap.get(roleId).add(battleArray);
        }else
        {
            battleArray.setCardIds(cardIds.toArray(a));
            dao.updateEntity(battleArray);
        }
        //这里需要检测编队数据的合法性, 以后有时间再开发
        sendJson.put(Field.BATTLE_ARRAY_RESULT, true);
        rspdClient(session, sendJson);
    }

    //获取战斗编组
    public BattleArray getCacheBattleArray(String roleId, int battleType)
    {
        List<BattleArray> battleArrayList = battleArrayHashMap.get(roleId);
        if(battleArrayList == null)
        {
            battleArrayList = dao.getViceEntities(roleId);
            battleArrayHashMap.put(roleId, battleArrayList);
        }
        BattleArray battleArray = null;
        for (int i = 0; i < battleArrayList.size(); i++)
        {
            if(battleArrayList.get(i).getBattleType() == battleType)
            {
                battleArray = battleArrayList.get(i);
                break;
            }
        }
        return battleArray;
    }
}
