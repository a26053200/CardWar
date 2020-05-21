package com.betel.cardwar.game.modules.player.service;

import com.betel.cardwar.game.modules.player.model.Player;
import com.betel.cardwar.game.modules.player.model.PlayerDao;
import com.betel.spring.IRedisService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/21
 */
public class PlayerService implements IRedisService<Player>
{
    @Autowired
    protected PlayerDao playerDao;

    @Override
    public void setTableName(String s)
    {
        playerDao.setTableName(s);
    }

    @Override
    public boolean addEntity(Player account)
    {
        return playerDao.addEntity(account);
    }

    @Override
    public boolean batchAddEntity(List<Player> list)
    {
        return playerDao.batchAddEntity(list);
    }

    @Override
    public Player getEntity(String s)
    {
        return playerDao.getEntity(s);
    }

    @Override
    public List<Player> getViceEntities(String s)
    {
        return playerDao.getViceEntities(s);
    }

    @Override
    public boolean updateEntity(Player account)
    {
        return playerDao.updateEntity(account);
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