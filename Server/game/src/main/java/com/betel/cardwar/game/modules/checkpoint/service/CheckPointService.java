package com.betel.cardwar.game.modules.checkpoint.service;

import com.alibaba.fastjson.JSONObject;
import com.betel.asd.BaseService;
import com.betel.asd.RedisDao;
import com.betel.cardwar.game.consts.Field;
import com.betel.cardwar.game.modules.checkpoint.ModuleConfig;
import com.betel.cardwar.game.modules.checkpoint.model.ChapterInfo;
import com.betel.cardwar.game.modules.checkpoint.model.CheckPoint;
import com.betel.cardwar.game.modules.checkpoint.model.CheckPointDao;
import com.betel.cardwar.game.modules.checkpoint.model.CheckPointInfo;
import com.betel.session.Session;
import com.betel.utils.IdGenerator;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/20
 */
public class CheckPointService extends BaseService<CheckPoint>
{
    @Autowired
    protected CheckPointDao dao;

    @Override
    public RedisDao<CheckPoint> getDao()
    {
        return dao;
    }

    /**
     * 获取章节信息
     * @param session
     */
    private void chapterInfo(Session session)
    {
        int chapterId = session.getRecvJson().getIntValue(Field.CHAPTER_ID);
        String roleId = session.getRecvJson().getString(Field.ROLE_ID);
        //该玩家所有已经通关的关卡
        List<CheckPoint> allCheckPoints = dao.getViceEntities(roleId);

        //已经通关的
        HashMap<Integer, CheckPoint> checkPointHashMap = new HashMap<>();
        for (int i = 0; i < allCheckPoints.size(); i++)
        {
            CheckPoint checkPoint = allCheckPoints.get(i);
            if(checkPoint.getChapter() == chapterId)
            {
                checkPointHashMap.put(checkPoint.getSection(), checkPoint);
            }
        }

        ChapterInfo chapterInfo = new ChapterInfo();
        chapterInfo.id = chapterId;
        chapterInfo.checkPoints = new ArrayList<>();
        List<CheckPointInfo> checkPointInfos = ModuleConfig.getCheckPointInfos(chapterId);
        for (int i = 0; i < checkPointInfos.size(); i++)
        {
            CheckPointInfo checkPointInfo = checkPointInfos.get(i);
            CheckPoint checkPoint = checkPointHashMap.get(checkPointInfo.section);
            if(checkPoint != null)
            {

            }else{
                checkPoint = new CheckPoint();
                checkPoint.setId(Long.toString(IdGenerator.getInstance().nextId()));
                checkPoint.setCheckpointId(checkPointInfo.id);
                checkPoint.setPassNum(0);
                checkPoint.setResetNum(0);
                checkPoint.setChapter(chapterId);
                checkPoint.setSection(checkPointInfo.section);
                checkPoint.setRewards(new boolean[5]);
                checkPoint.setStar(0);
            }
            chapterInfo.checkPoints.add(checkPoint);
        }
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.CHAPTER_INFO, chapterInfo);
        rspdClient(session, sendJson);
    }
}
