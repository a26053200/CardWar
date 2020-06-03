package com.betel.cardwar.game.modules.card.service;

import com.betel.asd.RedisDao;
import com.betel.cardwar.game.modules.card.model.Card;
import com.betel.cardwar.game.modules.card.model.CardDao;
import com.betel.spring.IRedisService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/14
 */
public class CardService implements IRedisService<Card>
{
    @Autowired
    protected CardDao dao;

    @Override
    public RedisDao<Card> getDao()
    {
        return dao;
    }

    @Override
    public void setTableName(String s)
    {
        dao.setTableName(s);
    }

    @Override
    public boolean addEntity(Card account)
    {
        return dao.addEntity(account);
    }

    @Override
    public boolean batchAddEntity(List<Card> list)
    {
        return dao.batchAddEntity(list);
    }

    @Override
    public Card getEntity(String s)
    {
        return dao.getEntity(s);
    }

    @Override
    public List<Card> getViceEntities(String s)
    {
        return dao.getViceEntities(s);
    }

    @Override
    public boolean updateEntity(Card c)
    {
        return dao.updateEntity(c);
    }

    @Override
    public void deleteEntity(List<String> list)
    {

    }

    @Override
    public void deleteEntity(String s)
    {

    }
}
