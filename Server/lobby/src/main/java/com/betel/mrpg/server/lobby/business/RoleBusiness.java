package com.betel.mrpg.server.lobby.business;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.mrpg.core.consts.Action;
import com.betel.mrpg.core.consts.Bean;
import com.betel.mrpg.core.consts.Field;
import com.betel.mrpg.core.consts.ReturnCode;
import com.betel.mrpg.core.utils.MathUtils;
import com.betel.mrpg.beans.Player;
import com.betel.mrpg.beans.Role;
import com.betel.database.RedisKeys;
import com.betel.session.Session;
import com.betel.session.SessionState;
import com.betel.utils.IdGenerator;
import com.betel.utils.TimeUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.List;

/**
 * @ClassName: PlayerBusiness
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/19 22:58
 */
public class RoleBusiness extends Business<Role>
{
    private class RoleRandom
    {
        static final String role_random_name1 = "role_random_name1";
        static final String role_random_name2 = "role_random_name2";
        static final String role_random_name3 = "role_random_name3";
    }


    final static Logger logger = LogManager.getLogger(RoleBusiness.class);

    private static final String ViceKey = "playerId";

    @Override
    public String getViceKey()
    {
        return ViceKey;
    }

    @Override
    public void Handle(Session session, String method)
    {
        switch (method)
        {
            case Action.ROLE_RANDOM_NAME:
                randomName(session);
                break;
            case Action.ROLE_CREATE:
                roleCreate(session);
                break;
            case Action.ROLE_ENTER_GAME:
                enterGame(session);
                break;
            default:
                logger.error("Unknown action:" + method);
                break;
        }
    }

    //产生随机名字
    private void randomName(Session session)
    {
        List<String> nameList1 = monitor.getDB().lrange(RoleRandom.role_random_name1, 0, -1);
        List<String> nameList2 = monitor.getDB().lrange(RoleRandom.role_random_name2, 0, -1);
        List<String> nameList3 = monitor.getDB().lrange(RoleRandom.role_random_name3, 0, -1);

        String name1 = nameList1.get(MathUtils.randomInt(0, nameList1.size()));
        String name2 = nameList2.get(MathUtils.randomInt(0, nameList2.size()));
        String name3 = nameList3.get(MathUtils.randomInt(0, nameList3.size()));

        String roleRandomName = name3 + name1 + name2;

        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.ROLE_NAME, roleRandomName);
        action.rspdClient(session, sendJson);
    }

    private void roleCreate(Session session)
    {
        String playerId = session.getRecvJson().getString(Field.PLAYER_ID);
        //先检测是否有重名的
        String roleName = session.getRecvJson().getString(Field.ROLE_NAME);
        if (!roleNameValid(session, roleName))
        {//角色名未通过检查
            //推送失败
            session.setState(SessionState.Fail);
            action.rspdClient(session);
            return;
        }
        //正式创建
        //Player player = (Player) monitor.getAction(Bean.PLAYER).getBusiness().getBeanByChannelId(session.getChannelId());
        Player player = (Player) monitor.getAction(Bean.PLAYER).getService().getEntryById(playerId);
        Role role = new Role();
        long roleId = IdGenerator.getInstance().nextId();
        role.setId(Long.toString(roleId));
        role.setPlayerId(player.getId());
        role.setRoleName(roleName);
        role.setHeadIcon(MathUtils.randomInt(1,6));
        role.setRegisterTime(TimeUtils.now2String());
        role.setLastLoginTime(TimeUtils.now2String());
        role.setLastLogoutTime(TimeUtils.now2String());
        service.addEntry(role);
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.ROLE_INFO, JSON.toJSON(role));
        //推送玩家信息
        action.rspdClient(session, sendJson);
    }

    private boolean roleNameValid(Session session, String roleName)
    {
        String roleId = monitor.getDB().get(Field.ROLE_NAME + RedisKeys.SPLIT + roleName);
        if (roleId == null)
        {//角色名还未被使用
            return true;
        }
        else
        {
            logger.info(String.format(ReturnCode.Register_not_yet + ":%s", roleName));
            rspdMessage(session, ReturnCode.Register_not_yet);
            return false;
        }
    }

    private void enterGame(Session session)
    {
        String playerId = session.getRecvJson().getString(Field.PLAYER_ID);
        List<Role> roleList = service.getViceEntrys(playerId);
        if (roleList.size() > 0)
        {
            JSONObject sendJson = new JSONObject();
            sendJson.put(Field.ROLE_INFO, JSON.toJSON(roleList.get(0)));//默认选择第一个角色
            //推送玩家信息
            action.rspdClient(session, sendJson);
        }
        else
        {
            //推送玩家失败
            session.setState(SessionState.Fail);
            action.rspdClient(session);
        }
    }
}
