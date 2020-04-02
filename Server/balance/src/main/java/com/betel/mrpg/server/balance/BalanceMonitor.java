package com.betel.mrpg.server.balance;

import com.betel.mrpg.core.consts.ServerName;
import com.betel.config.ServerConfigVo;
import com.betel.servers.center.CenterMonitor;

/**
 * @ClassName: BalanceMonitor
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2018/12/2 23:53
 */
public class BalanceMonitor extends CenterMonitor
{

    public BalanceMonitor(ServerConfigVo serverConfig)
    {
        super(serverConfig);
    }
}
