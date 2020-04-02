package com.betel.mrpg.server.room.beans;

import com.alibaba.fastjson.JSONObject;
import com.betel.mrpg.beans.Room;
import com.betel.mrpg.core.consts.Field;
import com.betel.mrpg.core.consts.Push;
import com.betel.mrpg.core.consts.ServerName;
import com.betel.mrpg.core.utils.Handler;
import com.betel.common.Monitor;
import io.netty.util.HashedWheelTimer;
import io.netty.util.Timeout;
import io.netty.util.TimerTask;

import java.util.concurrent.TimeUnit;

/**
 * @ClassName: HongJianRoom
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/3/21 22:59
 */
public class HongJianRoom
{
    private Room room;
    private HongJianDeck deck;
    private int currTurnPos;
    private int currTurnNum;
    private int turnDuration;//每轮持续时间,单位 毫秒

    public Room getRoom()
    {
        return room;
    }

    public HongJianDeck getDeck()
    {
        return deck;
    }

    public int getCurrTurnNum()
    {
        return currTurnNum;
    }

    public int getCurrTurnPos()
    {
        return currTurnPos;
    }

    private HashedWheelTimer turnTimer; //轮换计时器


    public HongJianRoom(Room room, HongJianDeck deck, int turnDuration)
    {
        this.room = room;
        this.deck = deck;
        this.turnDuration = turnDuration;
        turnTimer = new HashedWheelTimer();
    }

    //开始轮换出牌人
    public void startTurn(Monitor monitor)
    {
        currTurnPos = 0;
        currTurnNum = 0;
        sendWhoseTurn(monitor);
    }

    private void sendWhoseTurn(Monitor monitor)
    {
        JSONObject turnJson = new JSONObject();
        turnJson.put(Field.TURN_DURATION, turnDuration);
        turnJson.put(Field.ROOM_POS, getCurrTurnPos());
        turnJson.put(Field.TURN_NUM, getCurrTurnNum()); //当前轮数,首轮必须要出牌
        //getRoom().pushAll(Push.HJ_WHOSE_TURN, turnJson);
        monitor.pushToClient(getRoom().getRoleList()[0].getChannelId(), ServerName.JSON_GATE_SERVER, Push.HJ_WHOSE_TURN, turnJson);
        nextTurn(new Handler()
        {
            @Override
            public void call()
            {
                sendWhoseTurn(monitor);
            }
        });
    }

    private void nextTurn(Handler autoNextTurn)
    {
        turnTimer.newTimeout(new TimerTask()
        {
            @Override
            public void run(Timeout timeout) throws Exception
            {
                currTurnPos += 1;
                currTurnNum += 1;
                if (currTurnPos >= room.getRoleList().length)
                    currTurnPos = 0;
                System.out.println("切换出牌轮");
                autoNextTurn.call();
            }
        }, turnDuration, TimeUnit.MILLISECONDS);

    }

    public void stopTurnTimer()
    {
        if (turnTimer != null)
            turnTimer.stop();
    }
}
