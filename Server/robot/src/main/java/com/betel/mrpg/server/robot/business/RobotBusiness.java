package com.betel.mrpg.server.robot.business;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.mrpg.beans.Role;
import com.betel.mrpg.beans.Room;
import com.betel.mrpg.core.consts.*;
import com.betel.mrpg.core.utils.MathUtils;
import com.betel.mrpg.server.robot.beans.RobotClient;
import com.betel.consts.FieldName;
import com.betel.session.Session;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.HashMap;

public class RobotBusiness extends Business<RobotClient>
{

    static final String ROOM_ACTION = "room@";

    final static Logger logger = LogManager.getLogger(RobotBusiness.class);

    private HashMap<String, RobotClient> robotClientMap;
    //机器人计数器
    private int robotCounter = 1;

    public RobotBusiness()
    {
        super();
        robotClientMap = new HashMap<>();
    }
    @Override
    public void Handle(Session session, String method)
    {
        switch (method)
        {
            case Action.ROBOT_ENTER_ROOM:
                robotEnterRoom(session);
                break;
            case Action.DISBAND_ROOM:
                robotDisbandRoom(session);
                break;
            default:
                logger.error("Unknown action:" + method);
                break;
        }
    }

    @Override
    public void OnPushHandle(Session session, String method)
    {
        switch (method)
        {
            case Push.ROOM_INFO:
                OnPushRoomInfo(session);
                break;
            case Push.ENTER_ROOM:
                OnPushEnterRoom(session);
                break;
            case Push.ROOM_ROLE_STATE:
                OnPushRoleState(session);
                break;
            case Push.ROOM_LOAD_START:
                OnPushLoadStart(session);
                break;
            case Push.ROOM_GAME_START:
                OnPushGameStart(session);
                break;
            default:
                logger.error("Unknown push action:" + method);
                break;
        }
    }

    private RobotClient createRobotClient()
    {
        RobotClient robotClient = new RobotClient();
        robotClient.setId("robot_" + robotCounter++);
        Role role = new Role();
        role.setRoleState(RoomRoleState.Ready);
        role.setId(robotClient.getId());
        role.setRoleName(robotClient.getId());
        role.setSex(MathUtils.randomInt(0,2));
        role.setHeadIcon(MathUtils.randomInt(1,6));
        role.setRobot(true);
        robotClient.setRole(role);
        robotClientMap.put(robotClient.getId(), robotClient);
        return robotClient;
    }

    //通知机器人进入房间
    private void robotEnterRoom(Session session)
    {
        int roomId = session.getRecvJson().getInteger(FieldName.ID);
        JSONArray array = session.getRecvJson().getJSONArray(Field.ROBOT_INFO);
        for (int i = 0; i < array.size(); i++)
        {
            RobotClient robotClient = createRobotClient();
            JSONObject sendJson = robotClient.getRole().toRoomRoleJson();
            sendJson.put(Field.ROOM_ID,roomId);
            sendJson.put(FieldName.CHANNEL_ID, session.getChannelId());
            sendJson.put(Field.ROOM_POS,array.getJSONObject(i).getInteger(Field.ROOM_POS));
            sendJson.put(Field.ROLE_ID,robotClient.getRole().getId());
            //机器人进入房间
            monitor.sendToServer(ServerName.ROOM_SERVER,ROOM_ACTION + Action.ENTER_ROOM,sendJson);
        }
    }
    //通知机器人进入房间
    private void robotDisbandRoom(Session session)
    {
        int roomId = session.getRecvJson().getInteger(Field.ROOM_ID);
        String robotClientId = session.getRecvJson().getString(Field.ROBOT_CLIENT_ID);
        RobotClient robotClient = robotClientMap.get(robotClientId);
        if(robotClient != null)
        {
            robotClientMap.remove(robotClientId);
            logger.info("房间已经解散 id:" + roomId);
        }
    }
    //收到推送房间被创建
    private void OnPushRoomInfo(Session session)
    {
        String robotClientId = session.getRecvJson().getString(Field.ROBOT_CLIENT_ID);
        RobotClient robotClient = robotClientMap.get(robotClientId);
        if(robotClient != null)
        {
            Room room = new Room(monitor,ServerName.ROOM_SERVER, 4);
            room.fromJson(session.getRecvJson());
            robotClient.setRoom(room);
            robotClient.setRole(room.getRole(robotClientId));
            logger.info("房间已经创建 id:" + room.getId());
        }
    }

    //通知机器人进入房间
    private void OnPushEnterRoom(Session session)
    {
        String robotClientId = session.getRecvJson().getString(Field.ROBOT_CLIENT_ID);
        RobotClient robotClient = robotClientMap.get(robotClientId);
        if(robotClient != null)
        {
            Role role = new Role();
            role.fromJson(session.getRecvJson());
            //robotClient.getRoom().getRoleList().add(role);
            logger.info("玩家进入房间:" + role.getRoleName());
        }
    }
    //收到推送玩家状态改变
    private void OnPushRoleState(Session session)
    {
        String robotClientId = session.getRecvJson().getString(Field.ROBOT_CLIENT_ID);
        RobotClient robotClient = robotClientMap.get(robotClientId);
        if(robotClient != null)
        {
            String roleId = session.getRecvJson().getString(Field.ROLE_ID);
            Role role = robotClient.getRoom().getRole(roleId);
            RoomRoleState state = RoomRoleState.valueOf(session.getRecvJson().getString(Field.ROLE_STATE));
            role.setRoleState(state);
            if(!role.isRobot())
            {
                //当真正玩家准备好后,机器人直接推送加载完成,等等玩家开始
                if(state == RoomRoleState.Ready)
                {
                    sendRobotState(session,robotClient, RoomRoleState.Ready);
                }else if(state == RoomRoleState.LoadComplete)
                {
                    sendRobotState(session,robotClient, RoomRoleState.LoadComplete);
                }
            }
            logger.info("玩家状态: " + role.getRoleName() + " - " + state);
        }
    }

    private void sendRobotState(Session session, RobotClient robotClient, RoomRoleState state)
    {
        JSONObject sendJson = robotClient.getRole().toRoomRoleJson();
        sendJson.put(Field.ROOM_ID,robotClient.getRoom().getId());
        sendJson.put(Field.ROLE_ID,robotClient.getRole().getId());
        sendJson.put(Field.ROLE_STATE, state.toString());
        monitor.sendToServer(ServerName.ROOM_SERVER,ROOM_ACTION + Action.ROOM_ROLE_STATE,sendJson);
    }
    //收到推送加载开始
    private void OnPushLoadStart(Session session)
    {
        logger.info("加载开始");
    }

    //收到推送游戏开始
    private void OnPushGameStart(Session session)
    {
        logger.info("游戏开始");
    }
}
