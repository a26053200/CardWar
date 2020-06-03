package com.betel.cardwar.game.modules.card.controler;


import com.betel.cardwar.game.consts.DrawCardState;
import com.betel.cardwar.game.consts.Field;
import com.betel.cardwar.game.consts.ReturnCode;
import com.betel.cardwar.game.modules.ModuleConfig;
import com.betel.cardwar.game.modules.card.model.Card;
import com.betel.cardwar.game.modules.card.model.CardPool;
import com.betel.cardwar.game.modules.card.model.CardPoolItem;
import com.betel.cardwar.game.modules.card.model.DrawCard;
import com.betel.framework.spring.Controller;
import com.betel.framework.utils.DateUtils;
import com.betel.servers.action.ImplAction;
import com.betel.session.Session;
import com.betel.spring.IRedisService;
import com.betel.utils.IdGenerator;
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

    public DrawCardCtrl(ImplAction action, IRedisService service)
    {
        super(action, service);
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
        //开始抽卡
        int drawNum  = session.getRecvJson().getIntValue(Field.DRAW_CARD_NUM);
        if(drawNum != 1 && drawNum != 10)
        {
            rspdMessage(session, ReturnCode.Draw_Card_Num_Error);
            return;
        }

        String roleId = session.getRecvJson().getString(Field.ROLE_ID);
        //已经拥有的卡
        List<Card> ownerCardList = action.getService().getViceEntities(roleId);
        List<DrawCard> drawCards = new ArrayList<>();
        //抽卡过程
        //是否抽到2Star
        boolean bingo2Star = false;
        CardPoolItem bingo;
        for (int i = 0; i < (drawNum > 1 ? drawNum - 1 : drawNum); i++)
        {
            //先抽稀有度
            bingo = null;
            double random = Math.random();
            if(random < cardPool.baseProb1)
                bingo = getRandomCard(cardPool);
            else if(random < cardPool.baseProb2)
                bingo = getRandomCard(cardPool);
            else if(random < cardPool.baseProb3)
                bingo = getRandomCard(cardPool);
            if(bingo != null)
            {
                if(!bingo2Star)
                    bingo2Star = ModuleConfig.getCardInfo(bingo.cardId).star >= 2;
                drawCards.add(newDrawCard(bingo, ownerCardList, roleId));
            }
        }
        //最后一张必出2星, 前面一张2星以上的都没抽到则补抽
        if(drawNum > 1 && !bingo2Star)
        {
            bingo = null;
            double random = Math.random();
            if(random < cardPool.lastProb2)
                bingo = getRandomCard(cardPool);
            else if(random < cardPool.lastProb3)
                bingo = getRandomCard(cardPool);
            if(bingo != null)
                drawCards.add(newDrawCard(bingo, ownerCardList, roleId));
        }
        append(Field.DRAW_CARD_LIST, drawCards);
    }

    private DrawCard newDrawCard(CardPoolItem item, List<Card> ownerList,String roleId)
    {
        DrawCard drawCard = new DrawCard();
        drawCard.cardId = item.cardId;
        drawCard.state = DrawCardState.New;
        boolean alreadyOwned = false;
        for (int i = 0; i < ownerList.size(); i++)
        {
            if(ownerList.get(i).getCardId() == item.cardId)
            {
                drawCard.state = DrawCardState.Owned;
                drawCard.fragment = item.fragment;
                alreadyOwned = true;
                break;
            }
        }
        if(alreadyOwned)
        {
            //添加碎片
        }else{
            Card card = new Card();
            card.setId(Long.toString(IdGenerator.getInstance().nextId()));
            card.setCardId(item.cardId);
            card.setVid(roleId);
            ownerList.add(card);
            service.addEntity(card);
        }
        return drawCard;
    }

    private CardPoolItem getRandomCard(CardPool cardPool)
    {
        List<CardPoolItem> cardPoolItems = ModuleConfig.getCardPoolItems(cardPool.id);
        int random = (int)Math.floor(Math.random() * cardPoolItems.size());
        return cardPoolItems.get(random);
    }
}
