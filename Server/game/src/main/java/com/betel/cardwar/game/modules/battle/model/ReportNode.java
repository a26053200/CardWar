package com.betel.cardwar.game.modules.battle.model;

import com.betel.cardwar.game.consts.Camp;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.HashMap;
import java.util.List;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/7/13
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class ReportNode
{
    public int id;
    public String skillId;
    public int skillLevel;
}
