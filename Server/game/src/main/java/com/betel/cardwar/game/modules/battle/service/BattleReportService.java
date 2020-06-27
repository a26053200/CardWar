package com.betel.cardwar.game.modules.battle.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.BaseService;
import com.betel.asd.RedisDao;
import com.betel.cardwar.game.consts.Field;
import com.betel.cardwar.game.consts.ReturnCode;
import com.betel.cardwar.game.modules.battle.model.BattleReport;
import com.betel.cardwar.game.modules.battle.model.BattleReportDao;
import com.betel.cardwar.game.modules.checkpoint.model.CheckPoint;
import com.betel.cardwar.game.modules.checkpoint.service.CheckPointService;
import com.betel.session.Session;
import com.betel.session.SessionState;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/22
 */
public class BattleReportService extends BaseService<BattleReport>
{
    final static Logger logger = LogManager.getLogger(BattleReportService.class);

    @Autowired
    protected BattleReportDao dao;
    @Override
    public RedisDao<BattleReport> getDao()
    {
        return dao;
    }

    @Autowired
    protected CheckPointService checkPointService;

    /**
     * 生成战报
     * @param session
     */
    private void startBattle(Session session)
    {
        String roleId       = session.getRecvJson().getString(Field.ROLE_ID);
        int chapterId    = session.getRecvJson().getIntValue(Field.CHAPTER_ID);
        String checkpointId = session.getRecvJson().getString(Field.CHECKPOINT_ID);
        CheckPoint checkPoint = checkPointService.getCheckPoint(roleId, chapterId, checkpointId);
        if (checkPoint == null)
        {
            session.setState(SessionState.Fail);
            rspdMessage(session, ReturnCode.Checkpoint_Not_Found);
        }else{
            JSONObject sendJson = new JSONObject();
            //保存编组
            String battleArray = session.getRecvJson().getString(Field.BATTLE_ARRAY);
            sendJson.put(Field.BATTLE_REPORT, checkPoint.toRspdJson());
            sendJson.put(Field.BATTLE_ARRAY, battleArray);
            rspdClient(session, sendJson);
        }
    }


    /**
     * 生成战报
     * @param session
     */
    private void endBattle(Session session)
    {
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.BATTLE_REPORT, JSON.toJSON(new BattleReport()));
        rspdClient(session, sendJson);
    }

    /**
     * 生成战报
     * @param session
     */
    private void generateBattleReport(Session session)
    {
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.BATTLE_REPORT, JSON.toJSON(new BattleReport()));
        rspdClient(session, sendJson);
    }
}
