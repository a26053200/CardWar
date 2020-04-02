package com.betel.mrpg.core.consts;

public class Push
{

    //==================
    // Room
    //==================
    /**
     * 房间信息
     */
    public final static String ROOM_INFO = "push@room_info";
    /**
     * 玩家进入房间
     */
    public final static String ENTER_ROOM = "push@enter_room";
    /**
     * 玩家退出房间
     */
    public final static String EXIT_ROOM = "push@exit_room";
    /**
     * 房间玩家状态
     */
    public final static String ROOM_ROLE_STATE = "push@room_role_state";
    /**
     * 加载开始
     */
    public final static String ROOM_LOAD_START = "push@load_start";
    /**
     * 游戏正式开始
     */
    public final static String ROOM_GAME_START = "push@game_start";

    /**
     * (红尖游戏)发牌给单个角色
     */
    public final static String HJ_CARD_SLOT = "push@hj_card_slot";

    /**
     * (红尖游戏)推送当前轮到谁了
     */
    public final static String HJ_WHOSE_TURN = "push@hj_whose_turn";
}
