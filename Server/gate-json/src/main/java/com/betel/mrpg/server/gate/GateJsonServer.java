package com.betel.mrpg.server.gate;

import com.betel.mrpg.core.consts.ServerName;
import com.betel.mrpg.core.utils.ServerTools;
import com.betel.common.Monitor;
import com.betel.config.ServerConfigVo;
import com.betel.servers.forward.ServerClient;
import com.betel.servers.node.NodeServer;

/**
 * @ClassName: GateJsonServer
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/19 22:41
 */
public class GateJsonServer extends NodeServer
{

    public GateJsonServer(ServerConfigVo serverConfig, Monitor monitor)
    {
        super(serverConfig, monitor);
    }

    public static void main(String[] args) throws Exception
    {
        ServerConfigVo serverCfg = ServerTools.createServerConfig(args,ServerName.JSON_GATE_SERVER,ServerName.BALANCE_SERVER);
        GateJsonMonitor mnt = new GateJsonMonitor(serverCfg);
        GateJsonServer server = new GateJsonServer(serverCfg,mnt);
        server.setServerClient(new ServerClient(serverCfg, mnt));
        server.run();
    }
}