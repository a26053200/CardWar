package com.betel.mrpg.server.room.business;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.mrpg.beans.Role;
import com.betel.mrpg.beans.Room;
import com.betel.mrpg.core.consts.*;
import com.betel.mrpg.core.utils.Handler;
import com.betel.mrpg.server.room.beans.CardSlot;
import com.betel.mrpg.server.room.beans.HongJianDeck;
import com.betel.mrpg.server.room.beans.HongJianRoom;
import com.betel.session.Session;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.HashMap;

/**
 * @ClassName: HongJianBusiness
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/3/10 23:46
 */
public class HongJianBusiness extends Business<HongJianDeck>
{
    final static Logger logger = LogManager.getLogger(HongJianBusiness.class);

    private HashMap<Integer, HongJianRoom> roomMap;

    public HongJianBusiness()
    {
        super();
        roomMap = new HashMap<>();
    }


    @Override
    public void Handle(Session session, String method)
    {
        switch (method)
        {
            case Action.TURN_OPERATE:
                turnOperate(session);
                break;
            default:
                logger.error("Unknown action:" + method);
                break;
        }
    }


    public void startRound(Room normalRoom)
    {
        normalRoom.setRoomState(RoomState.PlayingGame);
        normalRoom.pushAll(Push.ROOM_GAME_START, new JSONObject());

        //发牌
        HongJianDeck deck = new HongJianDeck(normalRoom.getId());
        HongJianRoom hongJianRoom = new HongJianRoom(normalRoom, deck, 5000);
        roomMap.put(normalRoom.getId(), hongJianRoom);
        hongJianRoom.getDeck().NewDeck();//新牌
        hongJianRoom.getDeck().Shuffle();//洗牌
        //发牌给每个角色
        for (int i = 0; i < hongJianRoom.getRoom().getRoleList().length; i++)
        {
            Role role = hongJianRoom.getRoom().getRoleList()[i];
            if (role != null)
            {
                //CardSlot slot = deck.Deal(i, i == 0 ? 52 : 0);
                CardSlot slot = deck.Deal(i, 13);
                JSONObject cardJson = new JSONObject();
                cardJson.put(Field.CLIENT_ROLE_ID, role.getId());
                cardJson.put(Field.CARD_SLOT, slot.toJsonArray());
                cardJson.put(Field.ROOM_POS, role.getRoomPos());
                monitor.pushToClient(role.getChannelId(), ServerName.JSON_GATE_SERVER, Push.HJ_CARD_SLOT, cardJson);
            }
        }

        hongJianRoom.startTurn(monitor);
    }

    private void turnOperate(Session session)
    {
        int roomId = session.getRecvJson().getIntValue(Field.ROOM_ID);
        HongJianRoom room = roomMap.get(roomId);
        if (room != null)
        {
            room.stopTurnTimer();
        }
    }
}
