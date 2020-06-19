package com.betel.cardwar.game.consts;

/**
 * @ClassName: ReturnCode
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2018/12/8 1:14
 */
public class ReturnCode
{
    public static final String Error_unknown                = "未知错误";
    public static final String Error_no_role                = "改帐号还未创建角色";
    public static final String Error_already_role           = "改帐号已经存在角色";
    public static final String Register_not_yet             = "还未注册";
    public static final String Register_success             = "注册成功";
    public static final String Wrong_password               = "密码错误";
    public static final String Login_success                = "登录成功";
    public static final String RoleName_used                = "角色名已经被使用";

    //Card
    public static final String Card_Pool_Not_Exits          = "卡池不存在";
    public static final String Draw_Card_NotEnough_Res          = "资源不足";
    public static final String Card_Pool_Not_In_Time        = "卡池不在活动时间内";
    public static final String Draw_Card_Num_Error          = "抽卡次数不支持";
}
