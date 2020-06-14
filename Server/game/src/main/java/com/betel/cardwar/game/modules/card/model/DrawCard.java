package com.betel.cardwar.game.modules.card.model;

import com.betel.cardwar.game.consts.DrawCardState;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/2
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class DrawCard
{
    public int cardId;
    public DrawCardState state;
    public int fragmentStoneNum;

}
