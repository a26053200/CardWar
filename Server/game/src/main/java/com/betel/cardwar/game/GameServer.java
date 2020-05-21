package com.betel.cardwar.game;

import com.betel.cardwar.game.consts.ServerName;
import com.betel.common.Monitor;
import com.betel.config.ServerConfigVo;
import com.betel.servers.forward.ServerClient;
import com.betel.servers.node.NodeServer;
import com.betel.utils.ServerTools;

public class GameServer extends NodeServer
{
    public GameServer(ServerConfigVo serverConfig, Monitor monitor)
    {
        super(serverConfig, monitor);
    }

    public static void main(String[] args) throws Exception
    {
        ServerConfigVo serverCfg = ServerTools.createServerConfig(args, ServerName.GAME_SERVER,ServerName.BALANCE_SERVER);
        GameMonitor mnt = new GameMonitor(serverCfg);
        GameServer server = new GameServer(serverCfg,mnt);
        server.setServerClient(new ServerClient(serverCfg, mnt));
        server.run();
    }
}
