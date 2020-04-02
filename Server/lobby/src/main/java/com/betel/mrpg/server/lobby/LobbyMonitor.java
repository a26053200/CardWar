package com.betel.mrpg.server.lobby;

import com.betel.mrpg.core.consts.Bean;
import com.betel.mrpg.beans.Player;
import com.betel.mrpg.beans.Role;
import com.betel.mrpg.server.lobby.beans.Match;
import com.betel.mrpg.server.lobby.business.MatchBusiness;
import com.betel.mrpg.server.lobby.business.PlayerBusiness;
import com.betel.mrpg.server.lobby.business.RoleBusiness;
import com.betel.config.ServerConfigVo;
import com.betel.servers.action.ImplAction;
import com.betel.servers.node.NodeServerMonitor;
import com.betel.utils.BytesUtils;
import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @ClassName: LobbyMonitor
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/19 22:33
 */
public class LobbyMonitor extends NodeServerMonitor
{
    final static Logger logger = LogManager.getLogger(LobbyMonitor.class);

    public LobbyMonitor(ServerConfigVo serverCfgInfo)
    {
        super(serverCfgInfo);

        actionMap.put(Bean.PLAYER,    new ImplAction<>(this, Bean.PLAYER,       Player.class,       new PlayerBusiness()));
        actionMap.put(Bean.ROLE,      new ImplAction<>(this, Bean.ROLE,         Role.class,         new RoleBusiness()));
        actionMap.put(Bean.MATCH,      new ImplAction<>(this, Bean.MATCH,         Match.class,        new MatchBusiness()));
    }

    @Override
    public void recvJsonBuff(ChannelHandlerContext ctx, ByteBuf buf) {
        String json = BytesUtils.readString(buf);
        logger.info(String.format("[recv] json:%s", json));

        while(!json.startsWith("{")) {
            logger.info("Receive json buff 首字符异常:" + json);
            json = json.substring(1);
            logger.info("Receive json buff 纠正首字母:" + json);
        }

        logger.info(String.format("[recv] json:%s", json));
        this.recvJson(ctx, json);
    }
}
