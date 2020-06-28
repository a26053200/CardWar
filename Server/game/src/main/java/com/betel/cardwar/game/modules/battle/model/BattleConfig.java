package com.betel.cardwar.game.modules.battle.model;

import com.betel.asd.interfaces.IVo;

/**
 * @Description 战斗配置
 * @Author zhengnan
 * @Date 2020/6/24
 */
public class BattleConfig implements IVo
{

    private String id;
    private String roleId;
    private boolean auto;
    private int battleType;
    private int battleSpeed;
    private String[] cardIds;
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

    public boolean isAuto()
    {
        return auto;
    }

    public void setAuto(boolean auto)
    {
        this.auto = auto;
    }

    public int getBattleType()
    {
        return battleType;
    }

    public void setBattleType(int battleType)
    {
        this.battleType = battleType;
    }

    public int getBattleSpeed()
    {
        return battleSpeed;
    }

    public void setBattleSpeed(int battleSpeed)
    {
        this.battleSpeed = battleSpeed;
    }

    public String[] getCardIds()
    {
        return cardIds;
    }

    public void setCardIds(String[] cardIds)
    {
        this.cardIds = cardIds;
    }
}
