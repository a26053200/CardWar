package com.betel.mrpg.core.consts;

/**
 * @ClassName: ReturnCode
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2018/12/8 1:14
 */
public class ReturnCode
{
    public static final String Error_unknown                = "未知错误";
    public static final String Error_already_exits          = "用户名已经存在";

    public static final String Register_not_yet             = "还未注册";
    public static final String Register_success             = "注册成功";
    public static final String Wrong_password               = "密码错误";
    public static final String Login_success                = "登录成功";
    public static final String RoleName_used                = "角色名已经被使用";

    //匹配
    public static final String Match_success      = "匹配成功";
    public static final String Error_already_matching       = "你已经在匹配队列中了";
    public static final String Error_match_timeout       = "匹配超时";

    //房间
    public static final String Error_room_not_found       = "找不到改房间";
    public static final String Room_disband                 = "房间解散";

}
