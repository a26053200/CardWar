package com.betel.cardwar.game.modules.battle.model;

import com.betel.asd.interfaces.IVo;

/**
 * @Description 战报
 * @Author zhengnan
 * @Date 2020/6/22
 */
public class BattleReport implements IVo
{
    private String id;
    private String roleId;

    @Override
    public String getId()
    {
        return id;
    }

    @Override
    public void setId(String s)
    {
        id = s;
    }

    @Override
    public String getVid()
    {
        return roleId;
    }

    @Override
    public void setVid(String s)
    {
        roleId = s;
    }
}
