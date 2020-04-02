package com.betel.mrpg.server.lobby.business;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.mrpg.core.consts.*;
import com.betel.mrpg.core.utils.Handler;
import com.betel.mrpg.core.utils.MathUtils;
import com.betel.mrpg.server.lobby.beans.Match;
import com.betel.mrpg.beans.Role;
import com.betel.consts.FieldName;
import com.betel.session.Session;
import com.betel.session.SessionState;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.LinkedList;


/**
 * @ClassName: MatchBusiness
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/27 1:39
 */
public class MatchBusiness extends Business<Match>
{
    final static Logger logger = LogManager.getLogger(MatchBusiness.class);

    private int matchCounter = 1;
    //private int robotCounter = 1;

    private LinkedList<Match> matchQueue;

    public MatchBusiness() {
        super();
        matchQueue = new LinkedList<>();
    }

    @Override
    public void Handle(Session session, String method)
    {
        switch (method)
        {
            case Action.JOIN_MATCH:
                joinMatch(session);
                break;
            case Action.ENTER_ROOM:
                enterRoom(session);
                break;
            default:
                logger.error("Unknown action:" + method);
                break;
        }
    }

    private void enterRoom(Session session)
    {
        int roomId = session.getRecvJson().getIntValue(Field.ROOM_ID);
        String roleId = session.getRecvJson().getString(Field.ROLE_ID);
        boolean isRobot = session.getRecvJson().getBoolean(Field.IS_ROBOT);
        int index = session.getRecvJson().getIntValue(Field.ROOM_POS);
        Role role;
        if (isRobot)
        {
            role = new Role();
            role.setId(roleId);
        }else{
            role = (Role) monitor.getAction(Bean.ROLE).getService().getEntryById(roleId);
        }
        JSONObject roleJson = role.toJson();
        roleJson.put(Field.IS_ROBOT, isRobot);
        roleJson.put(Field.ROOM_ID,roomId);
        roleJson.put(Field.ROOM_POS,index);
        roleJson.put(FieldName.CHANNEL_ID,session.getChannelId());

        roleJson.put(Field.ROLE_STATE,RoomRoleState.UnReady.toString());
        //该玩家进入房间
        monitor.sendToServer(ServerName.ROOM_SERVER,"room@" + Action.ENTER_ROOM, roleJson);
    }

    private void joinMatch(Session session)
    {
        String channelId = session.getChannelId();
        String roleId = session.getRecvJson().getString(Field.ROLE_ID);
        Game game = Game.valueOf(session.getRecvJson().getString(Field.GAME));
        String gameMode = session.getRecvJson().getString(Field.GAME_MODE);
        Match match = getBeanByChannelId(channelId);
        if(match == null)
        {
            match = new Match();
            match.setSession(session);
            match.setId(matchCounter++);
            match.setRoleId(roleId);
            match.setGame(game);
            match.setGameMode(gameMode);
            match.setTimeoutTime(3000);
            match.start(new Handler()
            {
                @Override
                public void call()
                {
                    Match match = getBeanByChannelId(channelId);
                    session.setState(SessionState.Fail);//匹配超时
                    rspdMessage(match.getSession(),ReturnCode.Error_match_timeout);
                    removeBean(channelId);
                    matchQueue.remove(match);//移出队列
                }
            });
            this.putBean(session.getChannelId(),match);
            addMatch(match);
            //加3个机器人
            //robotJoinMatch("robot_" + robotCounter++ ,game,gameMode);
            //robotJoinMatch("robot_" + robotCounter++ ,game,gameMode);
            //robotJoinMatch("robot_" + robotCounter++ ,game,gameMode);
        }else{
            session.setState(SessionState.Fail);//匹配失败
            rspdMessage(session,ReturnCode.Error_already_matching);
        }
    }

    //机器人加入匹配
    private void robotJoinMatch(String robotId,Game game,String gameMode)
    {
        Match match = new Match();
        match.setId(matchCounter++);
        match.setRoleId(robotId);
        match.setRobot(true);
        match.setGame(game);
        match.setGameMode(gameMode);
        addMatch(match);
    }

    private void addMatch(Match newMatch)
    {
        matchQueue.add(newMatch);
        if(matchQueue.size() == 1)
        {//已经凑足一个牌桌了,转发给RoomServer创建房间,并返回给客户端,准备开始游戏

            //创建房间,第一个为房主
            JSONObject sendJson = new JSONObject();
            sendJson.put(FieldName.ACTION,"room@create_room");
            sendJson.put(Field.GAME,matchQueue.get(0).getGame().toString());
            sendJson.put(Field.GAME_MODE,matchQueue.get(0).getGameMode());
            JSONArray array = new JSONArray();
            for (int i = 0; i < matchQueue.size(); i++)
            {
                Match match = matchQueue.get(i);
                match.stop();//停止超时机制
                if (match.getSession() != null)
                {
                    removeBean(match.getSession().getChannelId());
                    rspdMessage(match.getSession(),ReturnCode.Match_success);
                }
                JSONObject roleJson;
                if (match.isRobot())
                {
                    roleJson = new JSONObject();
                    roleJson.put("id", match.getRoleId());
                    roleJson.put("roleName", match.getRoleId());
                    roleJson.put("sex", 0);
                    roleJson.put("headIcon", MathUtils.getRandom(6));
                    roleJson.put("isRobot",true);
                    array.add(i,roleJson);
                }else{
                    Role role = (Role) monitor.getAction(Bean.ROLE).getService().getEntryById(match.getRoleId());
                    roleJson = role.toJson();
                    roleJson.put("isRobot",false);
                    roleJson.put(FieldName.CHANNEL_ID,match.getSession().getChannelId());
                    array.add(i,roleJson);
                }
            }
            sendJson.put(Field.ROLE_LIST,array);

            //通知房间服务器创建房间
            monitor.sendToServer(ServerName.ROOM_SERVER,"room@" + Action.CREATE_ROOM,sendJson);

            //玩家第一个进入房间
            JSONObject enterRoomJson = new JSONObject();
            enterRoomJson.put(Field.ROLE_ID,newMatch.getRoleId());
            enterRoomJson.put(Field.ROOM_POS,0);
            monitor.sendToServer(ServerName.ROOM_SERVER,"room@" + Action.ENTER_ROOM,enterRoomJson);
            matchQueue.clear();//清除队列
        }else{

        }
    }
}
