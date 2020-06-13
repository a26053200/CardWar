package com.betel.cardwar.game.modules.role.events;

import com.betel.event.EventObject;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/13
 */
public class RoleEvent extends EventObject
{
    public static final String ROLE_ENTER_GAME = "ROLE_ENTER_GAME";

    private String roleId;

    public String getRoleId()
    {
        return roleId;
    }

    public RoleEvent(String types, String roleId)
    {
        super(types, false, false);
        this.roleId = roleId;
    }
}
