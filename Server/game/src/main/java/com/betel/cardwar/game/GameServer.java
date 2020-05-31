package com.betel.cardwar.game;

import com.betel.cardwar.game.consts.ServerName;
import com.betel.cardwar.game.utils.JSONArrayUtils;
import com.betel.common.Monitor;
import com.betel.config.ServerConfigVo;
import com.betel.servers.forward.ServerClient;
import com.betel.servers.http.HttpServer;
import com.betel.servers.node.NodeServer;
import com.betel.utils.ServerTools;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class GameServer extends NodeServer
{
    static final Logger logger = LogManager.getLogger(HttpServer.class);

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

    @Override
    protected void onServerStart()
    {
        logger.info("Game Server has started!");
    }
}
