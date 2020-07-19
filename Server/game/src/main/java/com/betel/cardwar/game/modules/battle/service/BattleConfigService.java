package com.betel.cardwar.game.modules.battle.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.BaseService;
import com.betel.asd.RedisDao;
import com.betel.cardwar.game.consts.Field;
import com.betel.cardwar.game.modules.battle.model.BattleConfig;
import com.betel.cardwar.game.modules.battle.model.BattleConfigDao;
import com.betel.session.Session;
import com.betel.utils.IdGenerator;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/24
 */
public class BattleConfigService extends BaseService<BattleConfig>
{
    final static Logger logger = LogManager.getLogger(BattleConfigService.class);

    @Autowired
    protected BattleConfigDao dao;
    @Override
    public RedisDao<BattleConfig> getDao()
    {
        return dao;
    }
    private HashMap<String, List<BattleConfig>> battleArrayHashMap = new HashMap<>();

    //战斗配置
    private void getBattleConfig(Session session)
    {
        String roleId       = session.getRecvJson().getString(Field.ROLE_ID);
        int battleType      = session.getRecvJson().getIntValue(Field.BATTLE_TYPE);
        BattleConfig battleArray = getCacheBattleArray(roleId, battleType);
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.BATTLE_AUTO, battleArray.isAuto());
        sendJson.put(Field.BATTLE_SPEED, battleArray.getBattleSpeed());
        sendJson.put(Field.BATTLE_ARRAY, battleArray.getCardIds());
        rspdClient(session, sendJson);
    }

    //只保存战斗编组
    private void saveBattleArray(Session session)
    {
        String roleId       = session.getRecvJson().getString(Field.ROLE_ID);
        int battleType      = session.getRecvJson().getIntValue(Field.BATTLE_TYPE);
        JSONArray cardIds   = session.getRecvJson().getJSONArray(Field.BATTLE_ARRAY);
        BattleConfig battleArray = getCacheBattleArray(roleId, battleType);
        String[] a = new String[cardIds.size()];
        saveBattle(session, roleId,battleType,cardIds.toArray(a),battleArray.getBattleSpeed(),battleArray.isAuto());
    }

    private void saveBattleConfig(Session session)
    {
        String roleId       = session.getRecvJson().getString(Field.ROLE_ID);
        int battleType      = session.getRecvJson().getIntValue(Field.BATTLE_TYPE);
        boolean battleAuto  = session.getRecvJson().getBooleanValue(Field.BATTLE_AUTO);
        int battleSpeed     = session.getRecvJson().getIntValue(Field.BATTLE_SPEED);
        BattleConfig battleArray = getCacheBattleArray(roleId, battleType);
        saveBattle(session, roleId, battleType,battleArray.getCardIds(),battleSpeed,battleAuto);
    }

    private void saveBattle(Session session, String roleId, int battleType, String[] cardIds, int battleSpeed, boolean battleAuto)
    {
        BattleConfig battleArray = getCacheBattleArray(roleId, battleType);
        JSONObject sendJson = new JSONObject();
        battleArray.setBattleSpeed(battleSpeed);
        battleArray.setCardIds(cardIds);
        battleArray.setAuto(battleAuto);
        dao.updateEntity(battleArray);
        //这里需要检测编队数据的合法性, 以后有时间再开发
        sendJson.put(Field.BATTLE_ARRAY_RESULT, true);
        rspdClient(session, sendJson);
    }

    //获取战斗编组
    public BattleConfig getCacheBattleArray(String roleId, int battleType)
    {
        List<BattleConfig> battleArrayList = battleArrayHashMap.get(roleId);
        if(battleArrayList == null)
        {
            battleArrayList = dao.getViceEntities(roleId);
            battleArrayHashMap.put(roleId, battleArrayList);
        }
        BattleConfig battleArray = null;
        for (int i = 0; i < battleArrayList.size(); i++)
        {
            if(battleArrayList.get(i).getBattleType() == battleType)
            {
                battleArray = battleArrayList.get(i);
                break;
            }
        }
        if(battleArray == null)
        {
            battleArray = new BattleConfig();
            battleArray.setId(Long.toString(IdGenerator.getInstance().nextId()));
            battleArray.setVid(roleId);
            battleArray.setAuto(false);
            battleArray.setBattleSpeed(1);
            battleArray.setBattleType(battleType);
            battleArray.setCardIds(new String[0]);
            dao.addEntity(battleArray);
            battleArrayHashMap.get(roleId).add(battleArray);
        }
        return battleArray;
    }
}
