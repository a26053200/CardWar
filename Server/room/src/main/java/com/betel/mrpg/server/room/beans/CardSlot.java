package com.betel.mrpg.server.room.beans;

import com.alibaba.fastjson.JSONArray;
import com.betel.mrpg.server.room.consts.CardSuit;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * @ClassName: CardSlot
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/3/11 0:43
 */
public class CardSlot
{
    private Card[] cards;
    private ArrayList<Card> cardList;

    public CardSlot(Card[] cards)
    {
        this.cards = cards;
        cardList = new ArrayList(Arrays.asList(cards));
    }

    public void addCard(Card card)
    {
        cardList.add(card);
    }

    public Card removeCard(int faceValue, CardSuit suit)
    {
        for (int i = 0; i < cards.length; i++)
        {
            Card card = cards[i];
            if (card.getFaceValue() == faceValue && card.getSuit() == suit)
            {
                cardList.remove(card);
                return card;
            }
        }
        return null;
    }

    public void addCards(Card card)
    {
        cardList.add(card);
    }

    public JSONArray toJsonArray()
    {
        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < cards.length; i++)
        {
            Card card = cards[i];

            jsonArray.add(card.toJson());
        }
        return jsonArray;
    }
}
