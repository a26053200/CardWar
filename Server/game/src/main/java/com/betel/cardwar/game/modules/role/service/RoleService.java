package com.betel.cardwar.game.modules.role.service;

import com.betel.cardwar.game.modules.role.model.Role;
import com.betel.cardwar.game.modules.role.model.RoleDao;
import com.betel.spring.IRedisService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/14
 */
public class RoleService implements IRedisService<Role>
{
    @Autowired
    protected RoleDao roleDao;

    @Override
    public void setTableName(String s)
    {
        roleDao.setTableName(s);
    }

    @Override
    public boolean addEntity(Role account)
    {
        return roleDao.addEntity(account);
    }

    @Override
    public boolean batchAddEntity(List<Role> list)
    {
        return roleDao.batchAddEntity(list);
    }

    @Override
    public Role getEntity(String s)
    {
        return roleDao.getEntity(s);
    }

    @Override
    public List<Role> getViceEntities(String s)
    {
        return roleDao.getViceEntities(s);
    }

    @Override
    public boolean updateEntity(Role account)
    {
        return roleDao.updateEntity(account);
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
