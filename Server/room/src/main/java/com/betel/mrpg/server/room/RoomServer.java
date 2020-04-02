package com.betel.mrpg.server.room;

import com.betel.mrpg.core.consts.ServerName;
import com.betel.mrpg.core.utils.ServerTools;
import com.betel.common.Monitor;
import com.betel.config.ServerConfigVo;
import com.betel.servers.forward.ServerClient;
import com.betel.servers.node.NodeServer;

/**
 * @ClassName: RoomServer
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/27 1:23
 */
public class RoomServer extends NodeServer
{
    public RoomServer(ServerConfigVo serverConfig, Monitor monitor)
    {
        super(serverConfig, monitor);
    }

    public static void main(String[] args) throws Exception
    {
        ServerConfigVo serverCfg = ServerTools.createServerConfig(args,ServerName.ROOM_SERVER,ServerName.BALANCE_SERVER);
        RoomMonitor mnt = new RoomMonitor(serverCfg);
        RoomServer server = new RoomServer(serverCfg,mnt);
        server.setServerClient(new ServerClient(serverCfg, mnt));
        server.run();
    }
}
