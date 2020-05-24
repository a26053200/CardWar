package com.betel.cardwar.game;

import com.betel.cardwar.game.modules.player.model.Player;
import com.betel.cardwar.game.modules.player.service.PlayerBusiness;
import com.betel.cardwar.game.modules.player.service.PlayerService;
import com.betel.cardwar.game.modules.role.model.Role;
import com.betel.cardwar.game.modules.role.service.RoleBusiness;
import com.betel.cardwar.game.modules.role.service.RoleService;
import com.betel.config.ServerConfigVo;
import com.betel.servers.node.NodeServerMonitor;
import com.betel.utils.BytesUtils;
import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class GameMonitor extends NodeServerMonitor
{
    final static Logger logger = LogManager.getLogger(GameMonitor.class);

    public GameMonitor(ServerConfigVo serverCfgInfo)
    {
        super(serverCfgInfo);
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");

        PlayerService playerService = (PlayerService) applicationContext.getBean("playerService");
        RoleService roleService     = (RoleService) applicationContext.getBean("roleService");

        pushService(Player.class, new PlayerBusiness(), playerService);
        pushService(Role.class, new RoleBusiness(), roleService);
    }

    @Override
    public void recvJsonBuff(ChannelHandlerContext ctx, ByteBuf buf)
    {
        String json = BytesUtils.readString(buf);
        logger.info(String.format("[recv] json:%s", json));
//
//        while(!json.startsWith("{")) {
//            logger.info("Receive json buff 首字符异常:" + json);
//            json = json.substring(1);
//            logger.info("Receive json buff 纠正首字母:" + json);
//        }
//
//        logger.info(String.format("[recv] json:%s", json));
//        this.recvJson(ctx, json);
    }
}
