package com.betel.mrpg.server.robot;

import com.betel.mrpg.core.consts.Bean;
import com.betel.mrpg.server.robot.beans.RobotClient;
import com.betel.mrpg.server.robot.business.RobotBusiness;
import com.betel.config.ServerConfigVo;
import com.betel.servers.action.ImplAction;
import com.betel.servers.node.NodeServerMonitor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class RobotMonitor extends NodeServerMonitor
{
    final static Logger logger = LogManager.getLogger(RobotMonitor.class);

    public RobotMonitor(ServerConfigVo serverCfgInfo)
    {
        super(serverCfgInfo);

        actionMap.put(Bean.ROBOT_CLIENT,    new ImplAction<>(this, Bean.ROBOT_CLIENT,       RobotClient.class,       new RobotBusiness()));
    }
}
