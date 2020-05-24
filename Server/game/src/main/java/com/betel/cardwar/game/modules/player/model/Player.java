package com.betel.cardwar.game.modules.player.model;

import com.betel.asd.BaseVo;

/**
 * @ClassName: Player
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/19 22:49
 */
public class Player extends BaseVo
{
    private String accountId;
    private String registerTime; //玩家第一次登陆游戏时间,即玩家在该服务器的注册时间
    private String lastLoginTime;//最后一次登陆时间
    private String lastLogoutTime;//最后一次登出时间

    @Override
    public String getVid()
    {
        return accountId;
    }

    @Override
    public void setVid(String accountId)
    {
        this.accountId = accountId;
    }

    public String getAccountId()
    {
        return accountId;
    }

    public void setAccountId(String accountId)
    {
        this.accountId = accountId;
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
}
