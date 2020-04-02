package com.betel.mrpg.server.robot.beans;

import com.alibaba.fastjson.JSONObject;
import com.betel.mrpg.beans.Role;
import com.betel.mrpg.beans.Room;

public class RobotClient
{
    private String id;
    private Role role;                //机器人角色

    private Room room;

    public String getId()
    {
        return id;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public Role getRole()
    {
        return role;
    }

    public void setRole(Role role)
    {
        this.role = role;
    }

    public Room getRoom()
    {
        return room;
    }

    public void setRoom(Room room)
    {
        this.room = room;
    }

    public void fromJson(JSONObject json)
    {

        //roleState = RoomRoleState.valueOf(json.getString("roleState"));
    }

    public JSONObject toJson()
    {
        JSONObject json = new JSONObject();
        json.put("id", id);
        json.put("roleInfo", role.toJson());
        return json;
    }
}
