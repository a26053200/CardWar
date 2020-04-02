package com.betel.mrpg.core.consts;

/**
 * @ClassName: 房间中玩家状态
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2019/1/30 23:04
 */
public enum  RoomRoleState
{
    /**
     * 未准备
     */
    UnReady,

    /**
     * 准备
     */
    Ready,

    /**
     * 加载中
     */
    Loading,

    /**
     * 加载完成
     */
    LoadComplete,

    /**
     * 正常游戏中
     */
    PlayingGame,

    /**
     * 游戏过程中掉线
     */
    Offline,

    /**
     * 游戏过程中重新连接
     */
    Reconnect,


    /**
     * 玩家托管,自动代打
     */
    Automatic
}
