package com.betel.mrpg.server.lobby.business;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.mrpg.core.consts.Action;
import com.betel.mrpg.core.consts.Bean;
import com.betel.mrpg.beans.Player;
import com.betel.mrpg.beans.Role;
import com.betel.mrpg.core.consts.Field;
import com.betel.session.Session;
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
public class PlayerBusiness extends Business<Player>
{

    final static Logger logger = LogManager.getLogger(PlayerBusiness.class);

    private static final String ViceKey = "accountId";

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
            case Action.PLAYER_LOGIN:
                login(session);
                break;
            case Action.PLAYER_LOGOUT:
                logout(session);
                break;
            default:
                logger.error("Unknown action:" + method);
                break;
        }
    }

    //处理登录游戏服务器
    private void login(Session session)
    {
        String aid = session.getRecvJson().getString(Field.ACCOUNT_ID);
        /*
        //验证登陆有效性
        String token = session.getRecvJson().getString(Field.TOKEN);
        if (JwtHelper.parseJWT(token))
            logger.info(String.format("User login game server success aid:%s token:%s", aid, token));
        else
            logger.info(String.format("User login game server fail aid:%s token:%s", aid, token));
        */
        JSONObject sendJson = new JSONObject();
        Player player;
        List<Player> playerList = service.getViceEntrys(aid);
        if (playerList.size() > 0)
        {
            player = playerList.get(0);
            player.setLastLoginTime(TimeUtils.now2String());
        }
        else
        {//自动注册
            player = new Player();
            long playerId = IdGenerator.getInstance().nextId();
            player.setId(Long.toString(playerId));
            player.setAccountId(aid);
            player.setRegisterTime(TimeUtils.now2String());
            player.setLastLoginTime(TimeUtils.now2String());
            player.setLastLogoutTime(TimeUtils.now2String());
            service.addEntry(player);
        }
        List<Role> roleList = monitor.getAction(Bean.ROLE).getService().getViceEntrys(player.getId());
        if(roleList.size() > 0)
            sendJson.put(Field.ROLE_INFO, JSON.toJSON(roleList.get(0)));//默认选择第一个角色
        sendJson.put(Field.PLAYER_ID, player.getId());
        action.rspdClient(session, sendJson);
    }

    //登出游戏服务器
    private void logout(Session session)
    {

    }
}
