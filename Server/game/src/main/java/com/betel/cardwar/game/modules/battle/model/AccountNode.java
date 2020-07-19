package com.betel.cardwar.game.modules.battle.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/7/13
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class AccountNode
{
    public int pid;
    public String accountId;
    public int atkerId;
    public int deferId;
    public boolean isHelpful;
    public int damRecoveryTP;    //伤害恢复的TP
    public int dam;              //伤害
    public int critDam; //暴击伤害
    public int atk;     //攻击
    public int def;     //防御
    public int crit;    //暴击倍数
    public int miss;   //是否命中
    public int acc;

}
