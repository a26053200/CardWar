package com.betel.mrpg.beans;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.BaseCommunication;
import com.betel.asd.interfaces.ICommunicationFilter;
import com.betel.mrpg.core.consts.Field;
import com.betel.mrpg.core.consts.Game;
import com.betel.mrpg.core.consts.RoomRoleState;
import com.betel.mrpg.core.consts.RoomState;
import com.betel.common.Monitor;

/**
 * @ClassName: ROOM
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/30 22:36
 */
public class Room extends BaseCommunication<Role>
{
    private int id;
    private Game game;
    private String gameMode;
    private RoomState roomState;
    private Role[] roleList;

    public Room(Monitor monitor, String gatewayName, int maxRoleNum)
    {
        super(monitor, gatewayName);
        roleList = new Role[maxRoleNum];
    }
    public Room(Monitor monitor, String gatewayName, String serverName, int maxRoleNum)
    {
        super(monitor, gatewayName, serverName);
        roleList = new Role[maxRoleNum];
    }
    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
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

    public RoomState getRoomState()
    {
        return roomState;
    }

    public void setRoomState(RoomState roomState)
    {
        this.roomState = roomState;
    }

    public Role[] getRoleList()
    {
        return roleList;
    }

    public boolean isAllState(RoomRoleState state)
    {
        for (int i = 0; i < roleList.length; i++)
        {
            Role role = roleList[i];
            if (role != null && role.getRoleState() != state)
                return false;
        }
        return true;
    }
    public Role getRole(String id)
    {
        for (int i = 0; i < roleList.length; i++)
        {
            Role role = roleList[i];
            if (role != null && id.equals(role.getId()))
                return role;
        }
        return null;
    }

    public void fromJson(JSONObject json)
    {
        this.setId(json.getIntValue("id"));
        this.setGame(Game.valueOf(json.getString("game")));
        this.setGameMode(json.getString("gameMode"));
        this.setRoomState(RoomState.Preparing);

        if (json.containsKey("roleList"))
        {
            JSONArray jsonArray = json.getJSONArray("roleList");
            for (int i = 0; i < jsonArray.size(); i++)
            {
                Role role = new Role();
                role.fromJson(jsonArray.getJSONObject(i));
                roleList[role.getRoomPos()] = role;
            }
        }
    }

    public JSONObject toJson()
    {
        JSONObject json = new JSONObject();
        json.put("id", id);
        json.put("game", game.toString());
        json.put("gameMode", gameMode);

        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < roleList.length; i++)
        {
            Role role = roleList[i];
            if (role != null)
            {
                jsonArray.add(role.toRoomRoleJson());
            }
        }
        json.put("roleList", jsonArray);
        return json;
    }

    @Override
    public void pushAll(String action, JSONObject json, ICommunicationFilter<Role> iCommunicationFilter)
    {
        for (int i = 0; i < roleList.length; i++)
        {
            Role role = roleList[i];
            if (role != null && iCommunicationFilter.filter(role))
            {
                json.put(Field.CLIENT_ROLE_ID, role.getId());
                monitor.pushToClient(role.getChannelId(), gatewayName, action, json);
            }
        }
    }

    @Override
    public void pushAll(String action, JSONObject json)
    {
        for (int i = 0; i < roleList.length; i++)
        {
            Role role = roleList[i];
            if (role != null)
            {
                json.put(Field.CLIENT_ROLE_ID, role.getId());
                monitor.pushToClient(role.getChannelId(), gatewayName, action, json);
            }
        }
    }
}
