package com.betel.mrpg.server.lobby.beans;

import com.betel.mrpg.core.consts.Game;
import com.betel.mrpg.core.utils.Handler;
import com.betel.session.Session;
import io.netty.util.HashedWheelTimer;
import io.netty.util.Timeout;
import io.netty.util.TimerTask;

import java.util.concurrent.TimeUnit;

/**
 * @ClassName: Match
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/27 1:27
 */
public class Match
{
    private int id;
    private Session session;
    private String roleId;
    private boolean isRobot;
    private Game game;        //游戏
    private String gameMode;    //游戏模式
    private int maxRoleNum;     //匹配最大玩家数量
    private long timeoutTime;   //超时时间 ms
    private long startTime;   //匹配开始时间 ms

    private HashedWheelTimer matchTimer; //匹配计时器

    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public Session getSession()
    {
        return session;
    }

    public void setSession(Session session)
    {
        this.session = session;
    }

    public String getRoleId()
    {
        return roleId;
    }

    public boolean isRobot()
    {
        return isRobot;
    }

    public void setRobot(boolean robot)
    {
        isRobot = robot;
    }

    public void setRoleId(String roleId)
    {
        this.roleId = roleId;
    }

    public Game getGame()
    {
        return game;
    }

    public void setGame(Game game)
    {
        this.game = game;
    }

    public String getGameMode()
    {
        return gameMode;
    }

    public void setGameMode(String gameMode)
    {
        this.gameMode = gameMode;
    }

    public int getMaxRoleNum()
    {
        return maxRoleNum;
    }

    public void setMaxRoleNum(int maxRoleNum)
    {
        this.maxRoleNum = maxRoleNum;
    }

    public long getTimeoutTime()
    {
        return timeoutTime;
    }

    public void setTimeoutTime(long timeoutTime)
    {
        this.timeoutTime = timeoutTime;
    }

    public long getStartTime()
    {
        return startTime;
    }

    public void setStartTime(long startTime)
    {
        this.startTime = startTime;
    }

    public void start(Handler timeoutCallback) {
        //创建匹配计时器,1秒支持一次
        matchTimer = new HashedWheelTimer();

        matchTimer.newTimeout(new TimerTask(){
                                  @Override
                                  public void run(Timeout timeout) throws Exception {
                                      System.out.println("匹配超时");
                                      timeoutCallback.call();
                                  }
                              }, timeoutTime, TimeUnit.MILLISECONDS);
    }

    public void stop()
    {
        if(matchTimer != null)
            matchTimer.stop();
    }
}
