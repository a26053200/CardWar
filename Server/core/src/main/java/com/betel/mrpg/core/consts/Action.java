package com.betel.mrpg.core.consts;

/**
 * @ClassName: Action
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2018/12/8 0:55
 */
public class Action
{
    //==================
    // Account
    //==================
    /**
     * 登陆帐号服务器
     */
    public final static String ACCOUNT_LOGIN = "account_login";
    /**
     * 登陆帐号服务器
     */
    public final static String ACCOUNT_REGISTER = "account_register";

    //==================
    // Player
    //==================
    /**
     * 登陆游戏服务器
     */
    public final static String PLAYER_LOGIN = "player_login";

    /**
     * 登出游戏服务器
     */
    public final static String PLAYER_LOGOUT = "player_logout";

    /**
     * 与服务器断开连接
     */
    public final static String PLAYER_OFFLINE = "player_offline";

    //==================
    // Role
    //==================
    /**
     * 获取随机角色名
     */
    public final static String ROLE_RANDOM_NAME = "role_random_name";
    /**
     * 角色创建
     */
    public final static String ROLE_CREATE = "role_create";
    /**
     * 选择角色并进入游戏
     */
    public final static String ROLE_ENTER_GAME = "role_enter_game";

    //==================
    // Match
    //==================
    /**
     * 加入匹配 (真实玩家)
     */
    public final static String JOIN_MATCH = "join_match";



    //==================
    // Room
    //==================
    /**
     * 创建房间
     */
    public final static String CREATE_ROOM = "create_room";
    /**
     * 进入房间
     */
    public final static String ENTER_ROOM = "enter_room";
    /**
     * 退出房间
     */
    public final static String EXIT_ROOM = "exit_room";
    /**
     * 更新房间内玩家状态
     */
    public final static String ROOM_ROLE_STATE = "role_state";
    /**
     * 解散房间
     */
    public final static String DISBAND_ROOM = "disband_room";
    //==================
    // Robot
    //==================
    /**
     * 通知机器人进入房间
     */
    public final static String ROBOT_ENTER_ROOM = "robot_enter_room";
    /**
     * 通知机器人状态改变
     */
    public final static String ROBOT_ROLE_STATE = "robot_role_state";
    //==================
    // HongJian
    //==================
    /**
     * 当前轮的操作
     */
    public final static String TURN_OPERATE = "robot_role_state";


}
