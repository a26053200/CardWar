package com.betel.mrpg.server.lobby;

import com.betel.mrpg.core.consts.ServerName;
import com.betel.mrpg.core.utils.ServerTools;
import com.betel.common.Monitor;
import com.betel.config.ServerConfigVo;
import com.betel.servers.forward.ServerClient;
import com.betel.servers.node.NodeServer;

/**
 * @ClassName: LobbyServer
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/19 22:33
 */
public class LobbyServer extends NodeServer
{
    public LobbyServer(ServerConfigVo serverConfig, Monitor monitor)
    {
        super(serverConfig, monitor);
    }

    public static void main(String[] args) throws Exception
    {
        ServerConfigVo serverCfg = ServerTools.createServerConfig(args,ServerName.LOBBY_SERVER,ServerName.BALANCE_SERVER);
        LobbyMonitor mnt = new LobbyMonitor(serverCfg);
        LobbyServer server = new LobbyServer(serverCfg,mnt);
        server.setServerClient(new ServerClient(serverCfg, mnt));
        server.run();
    }
}
