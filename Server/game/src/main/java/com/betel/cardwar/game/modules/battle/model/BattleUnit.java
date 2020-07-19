package com.betel.cardwar.game.modules.battle.model;

import com.betel.asd.interfaces.IVo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @Description
 * @Author zhengnan
 * @Date 2020/6/22
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BattleUnit
{
    public int sid;
    public String cardId;
    public String camp;
    public int layoutIndex;
    public int rank;
    public int level;
}
