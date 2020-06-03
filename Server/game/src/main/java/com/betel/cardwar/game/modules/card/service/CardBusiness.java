package com.betel.cardwar.game.modules.card.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.cardwar.game.consts.Field;
import com.betel.cardwar.game.modules.ModuleConfig;
import com.betel.cardwar.game.modules.card.controler.DrawCardCtrl;
import com.betel.cardwar.game.modules.card.model.Card;
import com.betel.cardwar.game.modules.card.model.CardPool;
import com.betel.session.Session;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/1
 */
public class CardBusiness extends Business<Card>
{
    final static Logger logger = LogManager.getLogger(CardBusiness.class);

    private DrawCardCtrl drawCardCtrl;

    //获取当前角色所拥有卡牌信息
    private void cardList(Session session)
    {
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.CARD_LIST, JSON.toJSON(getCardList(session)));
        action.rspdClient(session, sendJson);
    }

    //卡池信息
    private void cardPoolInfo(Session session)
    {
        HashMap<String, CardPool> cardPoolMap = ModuleConfig.getCardPoolMap();
        List<CardPool> cardPoolList = new ArrayList<>(cardPoolMap.values());
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.CARD_POOL_LIST, JSON.toJSON(cardPoolList));
        action.rspdClient(session, sendJson);
    }

    //抽卡
    private void drawCard(Session session)
    {
        if(drawCardCtrl == null)
            drawCardCtrl = new DrawCardCtrl(action, service);
        drawCardCtrl.newRspd(session);
        drawCardCtrl.send2client(session);
    }

    private List<Card> getCardList(Session session)
    {
        String roleId = session.getRecvJson().getString(Field.ROLE_ID);
        List<Card> cardList = service.getViceEntities(roleId);
        return cardList;
    }
}
