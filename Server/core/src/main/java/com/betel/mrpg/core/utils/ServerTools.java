package com.betel.mrpg.core.utils;

import com.betel.config.ServerConfigVo;
import com.betel.utils.StringUtils;

/**
 * @ClassName: ServerTools
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/1 1:50
 */
public class ServerTools
{
    /**
     * 获取String型的参数
     * @param args
     * @param key
     * @return
     */
    public static String getArguments(String[] args,String key)
    {
        for (int i = 0; i < args.length; i++)
        {
            if(key.equals(args[i]))
            {
                return args[i + 1];
            }
        }
        return null;
    }

    /**
     * 获取int型的参数
     * @param args
     * @param key
     * @return
     */
    public static int getArgumentsInt(String[] args,String key)
    {
        for (int i = 0; i < args.length; i++)
        {
            if(key.equals(args[i]))
            {
                String arg = args[i + 1];
                if (StringUtils.isNumber(arg))
                    return Integer.parseInt(arg);
            }
        }
        return 0;
    }

    /**
     * 根据启动参数创建服务器配置信息
     * @param args 服务器启动参数
     * @param serverName 服务器名称
     * @return 返回服务器配置信息
     * @throws Exception
     */
    public static ServerConfigVo createServerConfig(String[] args,String serverName) throws Exception
    {
        return createServerConfig(args,serverName, null);
    }
    /**
     * 根据启动参数创建服务器配置信息
     * @param args 服务器启动参数
     * @param serverName 服务器名称
     * @param centerServerName 中心服务器名称
     * @return 返回服务器配置信息
     * @throws Exception
     */
    public static ServerConfigVo createServerConfig(String[] args,String serverName,String centerServerName) throws Exception
    {
        int serverPort = ServerTools.getArgumentsInt(args,"-p");//当其服务器作为客户端时连接的服务器端口号
        if (serverPort == 0 )
            throw new Exception("You must specify the port number of the server. \"-p [port]\"");
        String centerServerHost = ServerTools.getArguments(args,"-ch");//中心服务器地址
        int centerServerPort = ServerTools.getArgumentsInt(args,"-cp");//中心服务器端口
        if (!StringUtils.isNullOrEmpty(centerServerName) )
        {
            if (centerServerPort == 0 )
                throw new Exception("You must specify the port number of the Center Server. \"-cp [port]\"");
        }
        String dbHost = ServerTools.getArguments(args,"-dh");//数据库地址
        int dbPort = ServerTools.getArgumentsInt(args,"-dp");//数据库端口
        int dbIndex = ServerTools.getArgumentsInt(args,"-di");//数据库索引
        String dbPw = ServerTools.getArguments(args,"-dpw");//数据库密码
        int decoderOffset = ServerTools.getArgumentsInt(args,"-do");//包头长度偏移量
        int decoderLen = ServerTools.getArgumentsInt(args,"-dl");   //包头长度
        ServerConfigVo cfg = new ServerConfigVo(
                serverName,
                serverPort,
                centerServerName,
                centerServerHost != null    ? centerServerHost  : "127.0.0.1",
                centerServerPort,
                dbHost != null              ? dbHost            : "",
                dbPort != 0                 ? dbPort            : 6379,
                dbIndex,
                dbPw != null                ? dbPw              : "",
                decoderOffset,
                decoderLen != 0             ? decoderLen        : 4
        );
        return cfg;
    }
}
