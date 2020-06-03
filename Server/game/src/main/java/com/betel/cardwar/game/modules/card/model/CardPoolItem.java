package com.betel.cardwar.game.modules.card.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/1
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CardPoolItem
{
    public int id;
    public String poolId;
    public String name;
    public String type;
    public int cardId;
    public int fragment;
}
