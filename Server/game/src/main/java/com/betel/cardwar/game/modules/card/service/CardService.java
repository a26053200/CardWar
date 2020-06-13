package com.betel.cardwar.game.modules.card.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.BaseService;
import com.betel.asd.RedisDao;
import com.betel.cardwar.game.consts.Field;
import com.betel.cardwar.game.modules.card.ModuleConfig;
import com.betel.cardwar.game.modules.card.controler.DrawCardCtrl;
import com.betel.cardwar.game.modules.card.model.Card;
import com.betel.cardwar.game.modules.card.model.CardDao;
import com.betel.cardwar.game.modules.card.model.CardInfo;
import com.betel.cardwar.game.modules.card.model.CardPool;
import com.betel.cardwar.game.modules.item.service.ItemService;
import com.betel.cardwar.game.modules.role.model.Role;
import com.betel.session.Session;
import com.betel.spring.IRedisService;
import com.betel.utils.IdGenerator;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/14
 */
public class CardService extends BaseService<Card>
{
    @Autowired
    protected CardDao dao;
    @Override
    public RedisDao<Card> getDao()
    {
        return dao;
    }
    @Autowired
    protected ItemService itemService;

    private DrawCardCtrl drawCardCtrl;

    //获取当前角色所拥有卡牌信息
    private void cardList(Session session)
    {
        String roleId = session.getRecvJson().getString(Field.ROLE_ID);
        List<Card> cardList = getOrInitCardList(roleId);
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.CARD_LIST, JSON.toJSON(cardList));
        rspdClient(session, sendJson);
    }

    private  List<Card> getOrInitCardList(String roleId)
    {
        List<Card> cardList = getCardList(roleId);
        if(cardList.size() == 0)
        {
            cardList = new ArrayList<>();
            List<CardInfo> cardInfoList = ModuleConfig.getCardInfoList();
            for (int i = 0; i < cardInfoList.size(); i++)
            {
                Card card = new Card();
                CardInfo cardInfo = cardInfoList.get(i);
                card.setId(Long.toString(IdGenerator.getInstance().nextId()));
                card.setCardId(cardInfo.id);
                card.setVid(roleId);
                card.setLevel(1);
                card.setStar(cardInfo.star);
                card.setRank(cardInfo.rank);
                card.setActive(false);//默认不激活
                cardList.add(card);
                dao.addEntity(card);
            }
        }
        return cardList;
    }

    //卡池信息
    private void cardPoolInfo(Session session)
    {
        HashMap<String, CardPool> cardPoolMap = ModuleConfig.getCardPoolMap();
        List<CardPool> cardPoolList = new ArrayList<>(cardPoolMap.values());
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.CARD_POOL_LIST, JSON.toJSON(cardPoolList));
        rspdClient(session, sendJson);
    }

    //抽卡
    private void drawCard(Session session)
    {
        if(drawCardCtrl == null)
            drawCardCtrl = new DrawCardCtrl(this);
        drawCardCtrl.newRspd(session);
        drawCardCtrl.send2client(session);
    }

    public void updateCard(Card card)
    {
        dao.updateEntity(card);
    }

    public List<Card> getCardList(String roleId)
    {
        return dao.getViceEntities(roleId);
    }

    public void addCardFragment(String roleId)
    {

    }
}
