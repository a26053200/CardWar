package com.betel.cardwar.game.modules.role.model;

import com.alibaba.fastjson.annotation.JSONField;
import com.betel.asd.interfaces.IVo;
import com.betel.cardwar.game.consts.GameConsts;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @ClassName: Role
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/19 22:50
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class Role implements IVo
{
    @JSONField(serialize=false)
    private String registerTime;    //第一次创建角色时间
    @JSONField(serialize=false)
    private String lastLoginTime;   //最后一次登陆时间
    @JSONField(serialize=false)
    private String lastLogoutTime;  //最后一次登出时间

    //游戏业务逻辑
    private String id;
    private String playerId;        //所属Player玩家id
    private String roleName;        //角色名
    private int sex;                //性别 0男 1女 其他未知
    private int headIcon;           //头像
    private int curStrength;            //体力
    private int maxStrength;  //当前等级最大体力
    private int[] money;                //货币
    private int level;                  //等级
    private long curExp;                //当前经验
    private long maxExp;      //升级所需最大经验
    private long ce;            //角色的总战斗力 Combat Effectiveness

    public Role()
    {
        money = new int[GameConsts.MaxMoneyTypeNum];
        for (int i = 0;i<money.length;i++)
            money[i] = 0;
    }

    @Override
    public String getId()
    {
        return id;
    }

    @Override
    public void setId(String id)
    {
        this.id = id;
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

    public int getCurStrength()
    {
        return curStrength;
    }

    public void setCurStrength(int curStrength)
    {
        this.curStrength = curStrength;
    }

    public int getMaxStrength()
    {
        return maxStrength;
    }

    public void setMaxStrength(int maxStrength)
    {
        this.maxStrength = maxStrength;
    }

    public int[] getMoney()
    {
        return money;
    }

    public void setMoney(int[] money)
    {
        this.money = money;
    }

    public int getLevel()
    {
        return level;
    }

    public void setLevel(int level)
    {
        this.level = level;
    }

    public long getCurExp()
    {
        return curExp;
    }

    public void setCurExp(long curExp)
    {
        this.curExp = curExp;
    }

    public long getMaxExp()
    {
        return maxExp;
    }

    public void setMaxExp(long maxExp)
    {
        this.maxExp = maxExp;
    }

    public long getCe()
    {
        return ce;
    }

    public void setCe(long ce)
    {
        this.ce = ce;
    }
}
