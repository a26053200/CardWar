package com.betel.cardwar.game.modules.battle.model;

import com.betel.asd.interfaces.IVo;

/**
 * @Description 战斗编组
 * @Author zhengnan
 * @Date 2020/6/24
 */
public class BattleArray implements IVo
{

    private String id;
    private String roleId;
    private int battleType;
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

    public int getBattleType()
    {
        return battleType;
    }

    public void setBattleType(int battleType)
    {
        this.battleType = battleType;
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
