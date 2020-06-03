package com.betel.cardwar.game.modules.card.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/2
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CardInfo
{
    public int id;
    public String name;     //卡片名称
    public int star;     //星级
    public int rank;     //rank
    public int rarity;   //稀有度
}
