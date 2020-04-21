---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2020/4/18 20:43
---

--技能触发策略
---@class SkillTriggerCondition
SkillTriggerCondition =
{
    CD              = "CD",                 -- 无条件	只要在非冷却下就会发动
    Prob            = "Prob",               -- 攻击概率	概率发动
    FullAnger       = "FullAnger",          -- 怒气满时释放
}

--目标切换模式
---@class TargetChangeMode
TargetChangeMode =
{
    One             = "One",                -- 只攻击一个目标直到目标死亡
    AttackNum       = "AttackNum",          -- 攻击次数	攻击一定次数后切换目标
    AttackTime      = "AttackTime",         -- 攻击时间	攻击一定时间后切换目标
    AttackProb      = "AttackProb",         -- 概率	攻击时有一定概率切换目标
    BufferFirst     = "BufferFirst",        -- Buffer优先 优先选择目标是否中指定buff
}


--目标优先规则
---@class TargetFirstOrder
TargetFirstOrder =
{
    Distance            = "Distance",           -- 距离优先
    HpLowestPercent     = "HpLowestPercent",          -- 最低生命值百分比
    HpHighestPercent    = "HpHighestPercent",           -- 最高生命值百分比
    BufferFirst         = "BufferFirst",        -- Buffer优先 优先选择目标是否中指定buff
}

---@class GridSelectType
GridSelectType =
{
    Friend = "Friend",
    Friend_Lowest = "Friend_Lowest",
    Friend_All = "Friend_All",
    Current = "Current",
    Col = "Col",
    Row = "Row",
    All = "All",
}
LayoutIndex2Col =
{
    [1] = {1,4,9},
    [2] = {2,5,8},
    [3] = {3,6,7},
    [4] = {1,4,9},
    [5] = {2,5,8},
    [6] = {3,6,7},
    [7] = {1,4,9},
    [8] = {2,5,8},
    [9] = {3,6,7},
}

LayoutIndex2Row =
{
    [1] = {1,2,3},
    [2] = {1,2,3},
    [3] = {1,2,3},
    [4] = {4,5,6},
    [5] = {4,5,6},
    [6] = {4,5,6},
    [7] = {7,8,9},
    [8] = {7,8,9},
    [9] = {7,8,9},
}

LayoutMapAll = {1,2,3,4,5,6,7,8,9}
