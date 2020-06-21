package com.betel.cardwar.game.modules.checkpoint.model;

import com.betel.asd.interfaces.IVo;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/20
 */
public class CheckPointInfo
{
    public String id;
    public String name;
    public String type;
    public int chapter;             //所属章
    public int section;             //所属节
    public int strength;
    public int maxPassNum;          //最大通关次数 0表示可无限次通关
    public int maxResetNum;         //最大重置次数 0表示可无需重置
    public String firstRewardId;    //首次掉落
    public String rewardId;         //掉落id
}
