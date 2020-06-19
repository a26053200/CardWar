package com.betel.cardwar.game.modules.card.controler;


import com.betel.asd.BaseService;
import com.betel.cardwar.game.consts.*;
import com.betel.cardwar.game.modules.card.ModuleConfig;
import com.betel.cardwar.game.modules.card.model.*;
import com.betel.cardwar.game.modules.card.service.CardService;
import com.betel.cardwar.game.modules.item.model.Item;
import com.betel.framework.spring.Controller;
import com.betel.framework.utils.DateUtils;
import com.betel.servers.action.ImplAction;
import com.betel.session.Session;
import com.betel.session.SessionState;
import com.betel.spring.IRedisService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/2
 */
public class DrawCardCtrl extends Controller
{
    final static Logger logger = LogManager.getLogger(DrawCardCtrl.class);

    private CardService cardService;

    public DrawCardCtrl(CardService service)
    {
        super(service);
        cardService = service;
    }

    @Override
    public void newRspd(Session session)
    {
        super.newRspd(session);
        String cardPoolName = session.getRecvJson().getString(Field.CARD_POOL_NAME);

        //获取卡池
        CardPool cardPool = ModuleConfig.getCardPool(cardPoolName);
        if(cardPool == null)
        {
            rspdMessage(session, ReturnCode.Card_Pool_Not_Exits);
            return;
        }
        //验证卡池是否过期
        Date startDate = DateUtils.strToDate(cardPool.startDate);    //卡池开始时间
        Date overDate = DateUtils.strToDate(cardPool.overDate);    //卡池结束时间
        Date now = new Date();
        if(DateUtils.getDistanceTimestamp(now, overDate) < 0)
        {
            rspdMessage(session, ReturnCode.Card_Pool_Not_In_Time);
            return;
        }
        int drawNum  = session.getRecvJson().getIntValue(Field.DRAW_CARD_NUM);
        if(drawNum != 1 && drawNum != 10)
        {
            rspdMessage(session, ReturnCode.Draw_Card_Num_Error);
            return;
        }

        //开始抽卡
        String roleId = session.getRecvJson().getString(Field.ROLE_ID);
        DrawCardType drawCardType = DrawCardType.values()[session.getRecvJson().getIntValue(Field.DRAW_CARD_TYPE)];
        Resources consumeResource;
        int consume = 0;
        boolean consumeEnable = false;//是否可以消费
        if(drawCardType == DrawCardType.Limit_Single)
        {
            consume = cardPool.limitDrawPrice;
            consumeResource = Resources.PayMoney;
        }else if(drawCardType == DrawCardType.Normal_Single)
        {
            consume = cardPool.singleDrawPrice;
            consumeResource = Resources.FreeMoney;
        }else {
            consume = cardPool.seriesDrawPrice;
            consumeResource = Resources.FreeMoney;
        }
        //优先消耗免费的资源,再消耗付费的资源
        consumeEnable = cardService.consumeRoleResource(roleId, consumeResource, consume);
        if(!consumeEnable && consumeResource == Resources.FreeMoney)
            consumeEnable = cardService.consumeRoleResource(roleId, Resources.PayMoney, consume);
        if(consumeEnable)
        {
            //已经拥有的卡
            List<Card> ownerCardList = cardService.getCardList(roleId);
            List<DrawCard> drawCards = new ArrayList<>();
            //抽卡过程
            boolean bingo2Star = false;//是否抽到2Star
            CardPoolItem bingo;
            for (int i = 0; i < (drawNum > 1 ? drawNum - 1 : drawNum); i++)
            {
                //先抽稀有度
                bingo = drawCardProb(cardPool, cardPool.baseProb3, cardPool.baseProb2, 1);
                if(!bingo2Star)
                    bingo2Star = ModuleConfig.getCardInfo(bingo.cardId).star >= 2;
                drawCards.add(newDrawCard(bingo, ownerCardList, roleId));
            }
            //最后一抽
            if(drawNum > 1)
            {
                if(bingo2Star)
                    bingo = drawCardProb(cardPool, cardPool.baseProb3, cardPool.baseProb2, 1);
                else//最后一张必出2星, 前面一张2星以上的都没抽到则补抽
                    bingo = drawCardProb(cardPool, cardPool.lastProb3, 1, 1);
                drawCards.add(newDrawCard(bingo, ownerCardList, roleId));
            }
            append(Field.DRAW_CARD_LIST, drawCards);
        }else{
            session.setState(SessionState.Fail);
            rspdMessage(session, ReturnCode.Draw_Card_NotEnough_Res);
        }
    }

    private CardPoolItem drawCardProb(CardPool cardPool, double star3Prob, double star2Prob, double star1Prob)
    {
        CardPoolItem bingo;
        double random = Math.random();
        if(random < star3Prob)
            bingo = getRandomCard(cardPool, 3);
        else if(random < star2Prob)
            bingo = getRandomCard(cardPool, 2);
        else // cardPool.baseProb3 + cardPool.baseProb2 + cardPool.baseProb1 == 1
            bingo = getRandomCard(cardPool, 1);
        return bingo;
    }

    private DrawCard newDrawCard(CardPoolItem item, List<Card> ownerList,String roleId)
    {
        DrawCard drawCard = new DrawCard();
        drawCard.cardId = item.cardId;
        drawCard.state = DrawCardState.New;
        for (int i = 0; i < ownerList.size(); i++)
        {
            Card card = ownerList.get(i);
            if(card.getCardId() == item.cardId)
            {
                drawCard.state = DrawCardState.Owned;
                if(card.isActive())
                {
                    //添加碎片
                    drawCard.fragmentStoneNum = item.fragmentStoneNum;
                    CardInfo cardInfo = ModuleConfig.getCardInfo(drawCard.cardId);
                    cardService.addFragmentStone(roleId, cardInfo.fragmentNum);
                }else{
                    logger.info("Draw a new card roleId:" + roleId);
                    card.setActive(true);
                    cardService.updateCard(card);
                }
                break;
            }
        }
        return drawCard;
    }

    private CardPoolItem getRandomCard(CardPool cardPool, int star)
    {
        List<CardPoolItem> cardPoolItems = ModuleConfig.getCardPoolItems(cardPool.id);
        List<CardPoolItem> starItems = new ArrayList<>();
        for (int i = 0; i < cardPoolItems.size(); i++)
        {
            CardInfo cardInfo = ModuleConfig.getCardInfo(cardPoolItems.get(i).cardId);
            if(cardInfo.star == star)
                starItems.add(cardPoolItems.get(i));
        }
        int random = (int)Math.floor(Math.random() * starItems.size());
        return starItems.get(random);
    }
}
