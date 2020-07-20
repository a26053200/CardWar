package com.betel.cardwar.game.modules.battle.model;

import com.alibaba.fastjson.JSONObject;
import com.betel.asd.interfaces.IVo;
import com.betel.cardwar.game.consts.Camp;

import java.util.HashMap;
import java.util.List;

/**
 * @Description 战报
 * @Author zhengnan
 * @Date 2020/6/22
 */
public class BattleReport implements IVo
{
    private String id;
    private String vid;

    private String roleId; //上传者
    private int roleLevel;
    private int chapterId; //战斗所在章节
    private String checkpointId; //战斗所在章节
    private int star;//几星通关
    private String lastPassTime;    //上次通关时间

    private BattleUnit[] battleUnits;//参战双方索引单位
    private ReportNode[] reportNodes;//战报节点
    private AccountNode[] accountNodes;//战报节点


    public JSONObject getSampleJSON()
    {
        JSONObject json = new JSONObject();
        json.put("id",id);
        json.put("roleId",roleId);
        json.put("roleLevel",roleLevel);
        json.put("chapterId",chapterId);
        json.put("checkpointId",checkpointId);
        json.put("star",star);
        json.put("lastPassTime",lastPassTime);
        json.put("battleUnits",battleUnits);
        return json;
    }

    @Override
    public String getId()
    {
        return id;
    }

    @Override
    public void setId(String s)
    {
        id = s;
    }

    @Override
    public String getVid()
    {
        return vid;
    }

    @Override
    public void setVid(String s)
    {
        vid = s;
    }

    public String getRoleId()
    {
        return roleId;
    }

    public void setRoleId(String roleId)
    {
        this.roleId = roleId;
    }

    public int getRoleLevel()
    {
        return roleLevel;
    }

    public void setRoleLevel(int roleLevel)
    {
        this.roleLevel = roleLevel;
    }

    public int getChapterId()
    {
        return chapterId;
    }

    public void setChapterId(int chapterId)
    {
        this.chapterId = chapterId;
    }

    public String getCheckpointId()
    {
        return checkpointId;
    }

    public void setCheckpointId(String checkpointId)
    {
        this.checkpointId = checkpointId;
    }

    public int getStar()
    {
        return star;
    }

    public void setStar(int star)
    {
        this.star = star;
    }

    public BattleUnit[] getBattleUnits()
    {
        return battleUnits;
    }

    public void setBattleUnits(BattleUnit[] battleUnits)
    {
        this.battleUnits = battleUnits;
    }

    public ReportNode[] getReportNodes()
    {
        return reportNodes;
    }

    public void setReportNodes(ReportNode[] reportNodes)
    {
        this.reportNodes = reportNodes;
    }

    public AccountNode[] getAccountNodes()
    {
        return accountNodes;
    }

    public void setAccountNodes(AccountNode[] accountNodes)
    {
        this.accountNodes = accountNodes;
    }

    public String getLastPassTime()
    {
        return lastPassTime;
    }

    public void setLastPassTime(String lastPassTime)
    {
        this.lastPassTime = lastPassTime;
    }

}
