package com.betel.cardwar.game.modules.card.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @Description 卡池
 * @Author zhengnan
 * @Date 2020/6/1
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CardPool
{
    public String id;
    public float baseProb1;     //基本1星的概率
    public float baseProb2;     //基本2星的概率
    public float baseProb3;     //基本3星的概率
    public float lastProb1;     //最后1次1星的概率
    public float lastProb2;     //最后1次2星的概率
    public float lastProb3;     //最后1次3星的概率
    public int maxTimes;        //最大次数
    public String startDate;    //卡池开始时间
    public String overDate;     //卡池结束时间
}
