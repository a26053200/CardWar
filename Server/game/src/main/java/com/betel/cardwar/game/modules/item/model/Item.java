package com.betel.cardwar.game.modules.item.model;

import com.betel.asd.interfaces.IVo;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/12
 */
public class Item implements IVo
{
    private String id;
    private String roleId;
    private int itemId;
    private int level;
    private int num;
    private boolean equipped; //是否装备

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

    public String getRoleId()
    {
        return roleId;
    }

    public int getItemId()
    {
        return itemId;
    }

    public void setItemId(int itemId)
    {
        this.itemId = itemId;
    }

    public int getLevel()
    {
        return level;
    }

    public void setLevel(int level)
    {
        this.level = level;
    }

    public int getNum()
    {
        return num;
    }

    public void setNum(int num)
    {
        this.num = num;
    }

    public boolean isEquipped()
    {
        return equipped;
    }

    public void setEquipped(boolean equipped)
    {
        this.equipped = equipped;
    }
}
