package com.betel.cardwar.game.modules.player.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.cardwar.game.consts.Action;
import com.betel.cardwar.game.consts.Field;
import com.betel.cardwar.game.modules.player.model.Player;
import com.betel.cardwar.game.modules.role.model.Role;
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

    //处理登录游戏服务器
    private void login(Session session)
    {
        String timeNow = TimeUtils.now2String();
        String aid = session.getRecvJson().getString(Field.ACCOUNT_ID);
        /*
        //验证登陆有效性
        String token = session.getRecvJson().getString(Field.TOKEN);
        if (JwtHelper.parseJWT(token))
            logger.info(String.format("User login game game success aid:%s token:%s", aid, token));
        else
            logger.info(String.format("User login game game fail aid:%s token:%s", aid, token));
        */
        JSONObject sendJson = new JSONObject();
        Player player;
        List<Player> playerList = service.getViceEntities(aid);
        if (playerList.size() > 0)
        {//非首次登陆
            player = playerList.get(0);
            player.setLastLoginTime(timeNow);
        }
        else
        {//首次登陆该游戏服务器,自动注册
            player = new Player();
            long playerId = IdGenerator.getInstance().nextId();
            player.setId(Long.toString(playerId));
            player.setAccountId(aid);
            player.setRegisterTime(timeNow);
            player.setLastLoginTime(timeNow);
            player.setLastLogoutTime(timeNow);
            service.addEntity(player);
        }

        sendJson.put(Field.PLAYER_ID, player.getId());
        action.rspdClient(session, sendJson);
        service.updateEntity(player);
    }

    //登出游戏服务器
    private void logout(Session session)
    {

    }
}
