package com.betel.mrpg.server.room;

import com.betel.mrpg.core.consts.Bean;
import com.betel.mrpg.beans.Room;
import com.betel.mrpg.server.room.beans.HongJianDeck;
import com.betel.mrpg.server.room.business.HongJianBusiness;
import com.betel.mrpg.server.room.business.RoomBusiness;
import com.betel.config.ServerConfigVo;
import com.betel.servers.action.ImplAction;
import com.betel.servers.node.NodeServerMonitor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @ClassName: RoomMonitor
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/27 1:26
 */
public class RoomMonitor extends NodeServerMonitor
{
    final static Logger logger = LogManager.getLogger(RoomMonitor.class);

    public RoomMonitor(ServerConfigVo serverCfgInfo)
    {
        super(serverCfgInfo);
        actionMap.put(Bean.ROOM,    new ImplAction<>(this, Bean.ROOM,       Room.class,       new RoomBusiness()));
        actionMap.put(Bean.HongJian,    new ImplAction<>(this, Bean.HongJian,       HongJianDeck.class,       new HongJianBusiness()));
    }
}
