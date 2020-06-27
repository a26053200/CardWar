package com.betel.cardwar.game;

import com.betel.asd.BaseService;
import com.betel.cardwar.game.modules.battle.model.BattleArray;
import com.betel.cardwar.game.modules.battle.model.BattleReport;
import com.betel.cardwar.game.modules.battle.service.BattleArrayService;
import com.betel.cardwar.game.modules.battle.service.BattleReportService;
import com.betel.cardwar.game.modules.card.model.Card;
import com.betel.cardwar.game.modules.card.service.CardService;
import com.betel.cardwar.game.modules.checkpoint.model.CheckPoint;
import com.betel.cardwar.game.modules.checkpoint.service.CheckPointService;
import com.betel.cardwar.game.modules.item.model.Item;
import com.betel.cardwar.game.modules.item.service.ItemService;
import com.betel.cardwar.game.modules.player.model.Player;
import com.betel.cardwar.game.modules.player.service.PlayerService;
import com.betel.cardwar.game.modules.role.model.Role;
import com.betel.cardwar.game.modules.role.service.RoleService;
import com.betel.config.ServerConfigVo;
import com.betel.event.EventDispatcher;
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

    private ApplicationContext applicationContext;
    private EventDispatcher eventDispatcher;

    public GameMonitor(ServerConfigVo serverCfgInfo)
    {
        super(serverCfgInfo);
        applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        eventDispatcher = new EventDispatcher();

        registerService(PlayerService.class,            Player.class);
        registerService(RoleService.class,              Role.class);
        registerService(CardService.class,              Card.class);
        registerService(ItemService.class,              Item.class);
        registerService(CheckPointService.class,        CheckPoint.class);
        registerService(BattleArrayService.class,       BattleArray.class);
        registerService(BattleReportService.class,      BattleReport.class);
        registerService(PlayerService.class,            Player.class);

        OnAllServiceLoaded();
    }

    //注册Service
    private void registerService(Class serviceClass, Class beanClass)
    {
        BaseService service = (BaseService) applicationContext.getBean(toLowerCaseFirstOne(serviceClass.getSimpleName()));
        pushService(beanClass, service);service.setEventDispatcher(eventDispatcher);

    }

    /**
     * 首字母转小写
     * @param s
     * @return
     */
    private String toLowerCaseFirstOne(String s){
        if(Character.isLowerCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
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
