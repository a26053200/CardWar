package com.betel.mrpg.server.account;

import com.alibaba.fastjson.JSONObject;
import com.betel.asd.Business;
import com.betel.mrpg.core.consts.Action;
import com.betel.mrpg.core.consts.ReturnCode;
import com.betel.mrpg.server.account.beans.Account;
import com.betel.consts.FieldName;
import com.betel.session.Session;
import com.betel.utils.IdGenerator;
import com.betel.utils.JwtHelper;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.List;

/**
 * @ClassName: AccountBusiness
 * @Description: TODO
 * @Author: zhengnan
 * @Date: 2018/12/5 23:04
 */
public class AccountBusiness extends Business<Account>
{
    private class Field
    {
        static final String USERNAME = "username";
        static final String PASSWORD = "password";
    }

    final static Logger logger = LogManager.getLogger(AccountBusiness.class);

    private static final String ViceKey = "username";
    @Override
    public String getViceKey()
    {
        return ViceKey;
    }

    @Override
    public void Handle(Session session, String method)
    {
        switch (method)
        {
            case Action.ACCOUNT_LOGIN:
                accountLogin(session);
                break;
            case Action.ACCOUNT_REGISTER:
                accountRegister(session);
                break;
            default:
                logger.error("Unknown action:"+ method);
                break;
        }
    }

    private void accountLogin(Session session)
    {
        String username = session.getRecvJson().getString(Field.USERNAME);
        String password = session.getRecvJson().getString(Field.PASSWORD);

        List<Account> allAccount = service.getViceEntrys(username);

        if (allAccount.size() > 0)
        {//已经注册过
            Account account = allAccount.get(0);
            if (account.getPassword().equals(password)) {//密码正确，登陆成功
                logger.info(String.format("用户:%s 登陆成功", username));
                //rspdMessage(session,ReturnCode.Login_success);
                onLoginSuccess(session, account.getId());
                updateAccount(session,account.getId());
            } else {//密码错误，登陆失败
                logger.info(String.format("用户:%s 登陆失败", username));
                rspdMessage(session,ReturnCode.Wrong_password);
            }
        }else{//还未注册过
            logger.info(String.format("用户:%s 登陆失败", username));
            rspdMessage(session,ReturnCode.Register_not_yet);
        }
    }

    private void onLoginSuccess(Session session, String account_id)
    {
        //游戏服务器的网关地址列表 json
        JSONObject gameServerJson = JSONObject.parseObject(monitor.getDB().get("GameServer"));
        JSONObject rspdJson = new JSONObject();
        rspdJson.put("aid", account_id);
        rspdJson.put("token", JwtHelper.createJWT(account_id));
        rspdJson.put("srvList", gameServerJson);
        action.rspdClient(session, rspdJson);
    }

    private void accountRegister(Session session)
    {
        String username = session.getRecvJson().getString(Field.USERNAME);
        String password = session.getRecvJson().getString(Field.PASSWORD);
        String clientIpAddress = session.getRecvJson().getString(FieldName.CLIENT_IP);
        List<Account> allAccount = service.getViceEntrys(username);
        if (allAccount.size() > 0)
        {//已经注册过
            //Account account = allAccount.get(0);
            rspdMessage(session,ReturnCode.Error_already_exits);
        }else{
            String nowTime = now();
            Account account = new Account();
            account.setId(Long.toString(IdGenerator.getInstance().nextId()));
            account.setUsername(username);
            account.setPassword(password);
            account.setRegisterTime(nowTime);
            account.setRegisterIp(clientIpAddress);
            account.setLastLoginTime(nowTime);
            account.setLastLoginIp(clientIpAddress);
            service.addEntry(account);
            rspdMessage(session,ReturnCode.Register_success);
        }
    }

    public void updateAccount(Session session, String accountId)
    {
        Account account = service.getEntryById(accountId);
        if(account != null)
        {
            String clientIpAddress = session.getRecvJson().getString(FieldName.CLIENT_IP);
            account.setLastLoginTime(now());
            account.setLastLoginIp(clientIpAddress);
            service.updateEntry(account);
        }else{
            logger.error("There is no account tha id = " + accountId);
        }
    }
}
