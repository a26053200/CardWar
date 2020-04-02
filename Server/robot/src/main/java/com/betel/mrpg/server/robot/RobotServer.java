package com.betel.mrpg.server.robot;

import com.betel.mrpg.core.consts.ServerName;
import com.betel.mrpg.core.utils.ServerTools;
import com.betel.common.Monitor;
import com.betel.config.ServerConfigVo;
import com.betel.servers.forward.ServerClient;
import com.betel.servers.node.NodeServer;

public class RobotServer extends NodeServer
{
    public RobotServer(ServerConfigVo serverConfig, Monitor monitor)
    {
        super(serverConfig, monitor);
    }

    public static void main(String[] args) throws Exception
    {
        ServerConfigVo serverCfg = ServerTools.createServerConfig(args,ServerName.ROBOT_SERVER, ServerName.BALANCE_SERVER);
        RobotMonitor mnt = new RobotMonitor(serverCfg);
        RobotServer server = new RobotServer(serverCfg,mnt);
        server.setServerClient(new ServerClient(serverCfg, mnt));
        server.run();
    }
}
