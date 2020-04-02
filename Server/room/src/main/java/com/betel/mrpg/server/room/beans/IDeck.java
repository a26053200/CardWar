package com.betel.mrpg.server.room.beans;

/**
 * 一副牌
 */
public interface IDeck
{
    /**
     * 获取这副牌的总数量
     * @return
     */
    int GetDeckNum();

    //新建一副牌
    void NewDeck();
    /**
     * 洗牌
     */
    void Shuffle();

    /**
     * 下一张牌
     * @return
     */
    Card GetNextCard();

    /**
     * 发牌
     */
    CardSlot Deal(int slotIndex, int num);
}
