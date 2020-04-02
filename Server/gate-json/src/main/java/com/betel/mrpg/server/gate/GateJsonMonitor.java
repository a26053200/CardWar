package com.betel.mrpg.server.gate;

import com.alibaba.fastjson.JSONObject;
import com.betel.mrpg.core.consts.Action;
import com.betel.mrpg.core.consts.ServerName;
import com.betel.config.ServerConfigVo;
import com.betel.consts.FieldName;
import com.betel.servers.forward.ForwardContext;
import com.betel.servers.forward.ForwardMonitor;
import com.betel.utils.BytesUtils;
import io.netty.channel.Channel;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


/**
 * @ClassName: GateJsonMonitor
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/20 23:50
 */
public class GateJsonMonitor extends ForwardMonitor
{
    final static Logger logger = LogManager.getLogger(GateJsonMonitor.class);

    public GateJsonMonitor(ServerConfigVo serverCfgInfo)
    {
        super(serverCfgInfo);
    }

    @Override
    protected void forward2Client(JSONObject jsonObject)
    {
        String channelId = jsonObject.getString(FieldName.CHANNEL_ID);
        removeIdentityInfo(jsonObject);
        ForwardContext clientCtx = getContext(channelId);
        if (clientCtx != null)
        {
            byte[] bytes = BytesUtils.string2Bytes(jsonObject.toString());
            sendBytes(clientCtx.getChannelHandlerContext().channel(),bytes);
            //delContext(clientCtx);
        }
        else
            logger.info("Client has not ChannelHandlerContext");
    }

    protected void OnChannelRemoved(Channel ch)
    {
        super.OnChannelRemoved(ch);
        JSONObject sendJson = new JSONObject();
        sendJson.put(FieldName.CHANNEL_ID, ch.id());
        //通知各服务器玩家断线
        sendToServer(ServerName.ROOM_SERVER,"room@" + Action.PLAYER_OFFLINE,sendJson);
        sendToServer(ServerName.LOBBY_SERVER,"lobby@" + Action.PLAYER_OFFLINE,sendJson);
    }
}

