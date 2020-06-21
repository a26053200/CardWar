package com.betel.cardwar.game.modules.checkpoint.model;

import com.betel.asd.interfaces.IVo;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/20
 */
public class CheckPoint implements IVo
{
    private String id;
    private String roleId;
    private String checkpointId;             //所属章
    private int chapter;             //所属章
    private int section;             //所属节
    private int star;               //通关星级
    private int passNum;            //通关次数
    private int resetNum;           //重置次数
    private String lastPassTime;    //上次通关时间
    private boolean[] rewards;      //奖励获取情况

    @Override
    public String getId()
    {
        return null;
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

    public String getCheckpointId()
    {
        return checkpointId;
    }

    public void setCheckpointId(String checkpointId)
    {
        this.checkpointId = checkpointId;
    }

    public int getChapter()
    {
        return chapter;
    }

    public void setChapter(int chapter)
    {
        this.chapter = chapter;
    }

    public int getSection()
    {
        return section;
    }

    public void setSection(int section)
    {
        this.section = section;
    }

    public int getStar()
    {
        return star;
    }

    public void setStar(int star)
    {
        this.star = star;
    }

    public int getResetNum()
    {
        return resetNum;
    }

    public void setResetNum(int resetNum)
    {
        this.resetNum = resetNum;
    }

    public int getPassNum()
    {
        return passNum;
    }

    public void setPassNum(int passNum)
    {
        this.passNum = passNum;
    }

    public String getLastPassTime()
    {
        return lastPassTime;
    }

    public void setLastPassTime(String lastPassTime)
    {
        this.lastPassTime = lastPassTime;
    }

    public boolean[] getRewards()
    {
        return rewards;
    }

    public void setRewards(boolean[] rewards)
    {
        this.rewards = rewards;
    }
}
