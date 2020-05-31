package com.betel.cardwar.game.modules.role.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.cardwar.game.consts.*;
import com.betel.cardwar.game.modules.ModuleConfig;
import com.betel.cardwar.game.modules.player.model.Player;
import com.betel.cardwar.game.modules.role.model.Role;
import com.betel.cardwar.game.modules.role.model.RoleLevel;
import com.betel.framework.utils.MathUtils;
import com.betel.session.Session;
import com.betel.session.SessionState;
import com.betel.utils.IdGenerator;
import com.betel.utils.TimeUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/5/21
 */
public class RoleBusiness extends Business<Role>
{
    class Field
    {
        public static final String PLAYER_ID        = "playerId";
        public static final String ROLE_NAME        = "roleName";
        public static final String ROLE_INFO        = "roleInfo";
    }

    final static Logger logger = LogManager.getLogger(RoleBusiness.class);

    //产生随机名字
    private void randomName(Session session)
    {
        List<String> nameList1 = ModuleConfig.getRoleName(0);
        List<String> nameList2 = ModuleConfig.getRoleName(1);
        List<String> nameList3 = ModuleConfig.getRoleName(2);

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
        List<Role> roleList = getRoleList(session);
        if (roleList.size() > 0)
        {//角色名未通过检查
            session.setState(SessionState.Fail);
            rspdMessage(session, ReturnCode.Error_already_role);
            return;
        }
        //正式创建
        Player player = (Player) monitor.getAction(Player.class).getService().getEntity(playerId);
        Role role = new Role();
        List<RoleLevel> roleLevels = ModuleConfig.getRoleLevelList();
        RoleLevel roleLevel = roleLevels.get(1); //默认1级
        long roleId = IdGenerator.getInstance().nextId();
        role.setId(Long.toString(roleId));
        role.setPlayerId(player.getId());
        role.setRoleName(roleName);
        role.setHeadIcon(MathUtils.randomInt(1,7));
        role.setRegisterTime(now());
        role.setLastLoginTime(now());
        role.setLastLogoutTime(now());

        role.setLevel(1);
        role.setCurStrength(roleLevel.strength);
        role.setMaxStrength(roleLevel.strength);
        //role.setCurExp(0);
        role.setMaxExp(roleLevel.needExp);
        service.addEntity(role);
        JSONObject sendJson = new JSONObject();
        sendJson.put(Field.ROLE_INFO, JSON.toJSON(role));
        //推送玩家信息
        action.rspdClient(session, sendJson);
    }

    private void enterGame(Session session)
    {
        List<Role> roleList = getRoleList(session);
        if (roleList.size() > 0)
        {
            Role role = roleList.get(0);
            logger.info(role.getRoleName() + " 进入游戏");
            role.setLastLoginTime(now());
            service.updateEntity(role);
            JSONObject sendJson = new JSONObject();
            sendJson.put(Field.ROLE_INFO, JSON.toJSON(role));//默认选择第一个角色
            //推送玩家信息
            action.rspdClient(session, sendJson);
        }
        else
        {
            //推送玩家失败
            //session.setState(SessionState.Fail);
            rspdMessage(session, ReturnCode.Error_no_role);
            action.rspdClient(session);
        }
    }

    private List<Role> getRoleList(Session session)
    {
        String playerId = session.getRecvJson().getString(Field.PLAYER_ID);
        List<Role> roleList = service.getViceEntities(playerId);
        return roleList;
    }

}
