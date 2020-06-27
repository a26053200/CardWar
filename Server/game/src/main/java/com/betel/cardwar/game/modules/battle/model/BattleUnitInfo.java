package com.betel.cardwar.game.modules.battle.model;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/22
 */
public class BattleUnitInfo
{
    public String id;
    public String name;         //名字
    public String avatarName;   //模型名
    public String type;         //类型
    public int cost;            //消耗
    public int atk;         //攻击力
    public float crit;         //爆击概率
    public float critPow;         //爆击量
    public float acc;          //命中率
    public int maxHp;         //生命值
    public int maxAnger;         //怒气
    public int speed;         //行动值
}
