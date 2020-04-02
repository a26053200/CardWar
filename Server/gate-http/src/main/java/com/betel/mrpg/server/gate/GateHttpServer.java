package com.betel.mrpg.server.gate;

import com.betel.mrpg.core.consts.ServerName;
import com.betel.mrpg.core.utils.ServerTools;
import com.betel.common.Monitor;
import com.betel.config.ServerConfigVo;
import com.betel.servers.forward.ServerClient;
import com.betel.servers.http.HttpServer;
import com.betel.servers.http.HttpServerMonitor;

/**
 * @ClassName: GateHttpServer
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2018/12/6 0:00
 */
public class GateHttpServer extends HttpServer
{

    public GateHttpServer(ServerConfigVo serverConfig, Monitor monitor)
    {
        super(serverConfig, monitor);
    }

    public static void main(String[] args) throws Exception
    {
        ServerConfigVo accountSrvCfg = ServerTools.createServerConfig(args,ServerName.GATE_HTTP_SERVER, ServerName.BALANCE_SERVER);
        HttpServerMonitor mnt = new HttpServerMonitor(accountSrvCfg);
        GateHttpServer server = new GateHttpServer(accountSrvCfg,mnt);
        server.setServerClient(new ServerClient(accountSrvCfg, mnt));
        server.run();
    }
}
