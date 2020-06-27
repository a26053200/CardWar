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
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Array;
import java.util.*;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/20
 */
public class CheckPointService extends BaseService<CheckPoint>
{
    final static Logger logger = LogManager.getLogger(CheckPointService.class);

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
        ChapterInfo chapterInfo = getOrCreateChapter(roleId, chapterId);
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.CHAPTER_INFO, chapterInfo.toRspdJson());
        rspdClient(session, sendJson);
    }

    //获取或者创建章节信息
    private ChapterInfo getOrCreateChapter(String roleId, int chapterId)
    {
        ChapterInfo chapterInfo = new ChapterInfo();
        chapterInfo.id = chapterId;
        chapterInfo.checkPoints = new ArrayList<>();
        //该玩家所有已经通关的关卡
        List<CheckPoint> allCheckPoints = dao.getViceEntities(roleId);
        if(allCheckPoints.size() > 0)
        {//已经战斗过
            for (int i = 0; i < allCheckPoints.size(); i++)
            {
                CheckPoint checkPoint = allCheckPoints.get(i);
                if(checkPoint.getChapter() == chapterId)
                    chapterInfo.checkPoints.add(checkPoint);
            }
            //排序
            chapterInfo.checkPoints.sort(new Comparator<CheckPoint>()
            {
                @Override
                public int compare(CheckPoint c1, CheckPoint c2)
                {
                    return Integer.compare(c1.getSection(), c2.getSection());
                }
            });
        }else{//第一次战斗
            List<CheckPointInfo> checkPointInfos = ModuleConfig.getCheckPointInfos(chapterId);
            for (int i = 0; i < checkPointInfos.size(); i++)
            {
                CheckPointInfo checkPointInfo = checkPointInfos.get(i);
                CheckPoint checkPoint = new CheckPoint();
                checkPoint.setId(Long.toString(IdGenerator.getInstance().nextId()));
                checkPoint.setVid(roleId);
                checkPoint.setCheckpointId(checkPointInfo.id);
                checkPoint.setPassNum(0);
                checkPoint.setResetNum(0);
                checkPoint.setChapter(chapterId);
                checkPoint.setSection(checkPointInfo.section);
                checkPoint.setRewards(new boolean[5]);
                checkPoint.setStar(0);
                dao.addEntity(checkPoint);
                chapterInfo.checkPoints.add(checkPoint);
            }
        }
        return chapterInfo;
    }

    //获取章节最新的关卡
    public CheckPoint getChapterNewestCheckPoint(String roleId, int chapterId)
    {
        ChapterInfo chapterInfo = getOrCreateChapter(roleId, chapterId);
        for (int i = 0; i < chapterInfo.checkPoints.size(); i++)
        {
            CheckPoint checkPoint = chapterInfo.checkPoints.get(i);
            if(checkPoint.getStar() == 0)//没用通关过
            {
                return checkPoint;
            }
        }
        return null;
    }

    public CheckPoint getCheckPoint(String roleId, int chapterId, String checkpointId)
    {
        ChapterInfo chapterInfo = getOrCreateChapter(roleId, chapterId);
        for (int i = 0; i < chapterInfo.checkPoints.size(); i++)
        {
            CheckPoint checkPoint = chapterInfo.checkPoints.get(i);
            if(checkPoint.getCheckpointId().equals(checkpointId))//没用通关过
            {
                return checkPoint;
            }
        }
        return null;
    }
}
