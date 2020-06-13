package com.betel.cardwar.game.modules.card.model;

import com.betel.asd.interfaces.IVo;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/14
 */
public class Card implements IVo
{

    private String id;
    private int cardId;
    private String roleId;        //所属Role玩家id
    private boolean active;
    private int level;
    private int star;
    private int rank;
    private int ce;

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

    public boolean isActive()
    {
        return active;
    }

    public void setActive(boolean active)
    {
        this.active = active;
    }

    public int getCardId()
    {
        return cardId;
    }

    public void setCardId(int cardId)
    {
        this.cardId = cardId;
    }
    public int getLevel()
    {
        return level;
    }

    public void setLevel(int level)
    {
        this.level = level;
    }

    public int getStar()
    {
        return star;
    }

    public void setStar(int star)
    {
        this.star = star;
    }

    public int getRank()
    {
        return rank;
    }

    public void setRank(int rank)
    {
        this.rank = rank;
    }

    public int getCe()
    {
        return ce;
    }

    public void setCe(int ce)
    {
        this.ce = ce;
    }
}
