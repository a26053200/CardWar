package com.betel.mrpg.server.room.beans;

import com.alibaba.fastjson.JSONObject;
import com.betel.mrpg.server.room.consts.CardSuit;
import com.betel.mrpg.server.room.consts.CardType;

/**
 * @ClassName: Card
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/3/5 22:22
 */
public class Card
{
    private CardSuit suit;
    private int faceValue;

    public CardSuit getSuit()
    {
        return suit;
    }

    public void setSuit(CardSuit suit)
    {
        this.suit = suit;
    }

    public int getFaceValue()
    {
        return faceValue;
    }

    public void setFaceValue(int faceValue)
    {
        this.faceValue = faceValue;
    }

    public void setCardType(CardType cardType)
    {
        faceValue = cardType.ordinal();
    }

    public CardType getCardType(int faceValue)
    {
        return CardType.values()[faceValue];
    }

    public JSONObject toJson()
    {
        JSONObject json = new JSONObject();
        json.put("suit", suit.toString());
        json.put("faceValue", faceValue);
        return json;
    }
}
