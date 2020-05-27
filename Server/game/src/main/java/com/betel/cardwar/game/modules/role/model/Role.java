package com.betel.cardwar.game.modules.role.model;

import com.betel.asd.BaseVo;
import com.betel.cardwar.game.consts.GameConsts;

/**
 * @ClassName: Role
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/19 22:50
 */
public class Role extends BaseVo
{
    private String channelId;       //频道ID 用于推送
    private String playerId;        //所属Player玩家id
    private String registerTime;    //第一次创建角色时间
    private String lastLoginTime;   //最后一次登陆时间
    private String lastLogoutTime;  //最后一次登出时间

    //游戏业务逻辑
    private String roleName;        //角色名
    private int sex;                //性别 0男 1女 其他未知
    private int headIcon;           //头像
    private int strength;           //体力
    private int[] money;            //货币

    public Role()
    {
        money = new int[GameConsts.MaxMoneyTypeNum];
        for (int i = 0;i<money.length;i++)
            money[i] = 0;
    }
    @Override
    public String getVid()
    {
        return playerId;
    }

    @Override
    public void setVid(String playerId)
    {
        this.playerId = playerId;
    }

    public String getChannelId()
    {
        return channelId;
    }

    public void setChannelId(String channelId)
    {
        this.channelId = channelId;
    }

    public String getPlayerId()
    {
        return playerId;
    }

    public void setPlayerId(String playerId)
    {
        this.playerId = playerId;
    }

    public String getRegisterTime()
    {
        return registerTime;
    }

    public void setRegisterTime(String registerTime)
    {
        this.registerTime = registerTime;
    }

    public String getLastLoginTime()
    {
        return lastLoginTime;
    }

    public void setLastLoginTime(String lastLoginTime)
    {
        this.lastLoginTime = lastLoginTime;
    }

    public String getLastLogoutTime()
    {
        return lastLogoutTime;
    }

    public void setLastLogoutTime(String lastLogoutTime)
    {
        this.lastLogoutTime = lastLogoutTime;
    }

    public String getRoleName()
    {
        return roleName;
    }

    public void setRoleName(String roleName)
    {
        this.roleName = roleName;
    }

    public int getSex()
    {
        return sex;
    }

    public void setSex(int sex)
    {
        this.sex = sex;
    }

    public int getHeadIcon()
    {
        return headIcon;
    }

    public void setHeadIcon(int headIcon)
    {
        this.headIcon = headIcon;
    }

    public int getStrength()
    {
        return strength;
    }

    public void setStrength(int strength)
    {
        this.strength = strength;
    }

    public int[] getMoney()
    {
        return money;
    }

    public void setMoney(int[] money)
    {
        this.money = money;
    }
}
