package com.betel.mrpg.server.room.beans;

import com.betel.mrpg.server.room.consts.CardSuit;

import java.util.Random;

/**
 * @ClassName: HongJianDeck
 * @Description: 红尖 一副牌 54张 52个基本牌 4中花色 加上大小王 其中2比Ace大
 * @Author: zhengnan
 * @Date: 2019/3/10 23:47
 */
public class HongJianDeck implements IDeck
{
    private int roomId;
    private int deckNum = 52;
    private Card[] cards;
    private int position = 0;

    public int getRoomId()
    {
        return roomId;
    }

    public HongJianDeck(int roomId)
    {
        this.roomId = roomId;
    }

    @Override
    public int GetDeckNum()
    {
        return deckNum;
    }

    @Override
    public void NewDeck()
    {
        //创建牌的方法
        //1.定义花色数组
        CardSuit[] suits = {CardSuit.Diamond, CardSuit.Club, CardSuit.Heart, CardSuit.Spade};
        //2.定义牌面数组
        int[] numbers = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
        //3.定义王
        //int[] kings = {16, 17};

        //4.使用循环将牌存储到pokers数组
        cards = new Card[deckNum];

        int index = 0;
        for (int i = 0; i < numbers.length; i++)
        {
            for (int j = 0; j < suits.length; j++)
            {
                Card card = new Card();
                card.setSuit(suits[j]);
                card.setFaceValue(numbers[i]);
                cards[index++] = card;
            }
        }
    }

    /**
     * 洗牌
     */
    @Override
    public void Shuffle()
    {
        //3.洗牌
        for (int i = 0; i < cards.length; i++)
        {
            //a.创建随机数
            Random rd = new Random();
            //b.获取随机数的下标
            int r = rd.nextInt(cards.length);
            Card temp = cards[i];
            cards[i] = cards[r];
            cards[r] = temp;
        }

    }

    @Override
    public Card GetNextCard()
    {
        if(position < cards.length)
            return cards[position++];
        else
            return null;
    }

    //发牌
    @Override
    public CardSlot Deal(int slotIndex, int num)
    {
        Card[] slotCards = new Card[num];
        if (position < deckNum)
            System.arraycopy(cards,position,slotCards,0,num);
        position += num;
        return new CardSlot(slotCards);
    }
}
