---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2019/5/11 10:45
--- 游戏常量和全局枚举
---

---=========================================================================
--- 游戏常量
---=========================================================================

USED_HERO_MAX = 3              -- 最大上阵英雄数
EQUIP_POS_MAX = 3              -- 最大装备位
HERO_MAX_AWAKEN = 1            -- 最大觉醒等级
HERO_BASE_MAX_LEVEL = 50       -- 觉醒0时的最大等级
HERO_AWAKEN_UP_LEVEL = 10      -- 觉醒增加的最大等级
HERO_AWAKEN_UP_ATTRIBUTE = 0.1 -- 觉醒增加的属性值
HERO_MOOD_MAX = 100       -- 心情的最大值


OutStageDistance = 12  --登场距离
OutStageDistance_Next = 30  --登场距离
OnStageDuration = 1  --登场时间

RankFrameUrl =
{
    [1] = "Atlas/RankFrame/dikuang_16_1_0.png",
    [2] = "Atlas/RankFrame/dikuang_16_1_1.png",
    [3] = "Atlas/RankFrame/dikuang_16_1_2.png",
    [4] = "Atlas/RankFrame/dikuang_16_1_3.png",
    [5] = "Atlas/RankFrame/dikuang_16_1_4.png",
    [6] = "Atlas/RankFrame/dikuang_16_1_5.png",
}

---=========================================================================
--- 支撑系统
---=========================================================================
--空参数
EmptyParam = {}

--服务器返回会话状态
---@class SessionState
SessionState =
{
    Success = 0,
    Fail = 1,
    UnknowError = 2
}

--预加载类型
PreLoadType =
{
    Scene = "Scene",
    Texture = "Texture", --贴图
    Prefab = "Prefab"    --预制件
}

--预加载任务类型
PreloadingTaskType =
{
    GC              = "GC",         --GC
    EnterScene      = "EnterScene",         --进入场景
    LoadScene       = "LoadScene",          --加载场景
    InstanceScene   = "InstanceScene",      --实例化
    Callback        = "Callback",         --进入子场景
}
---=========================================================================
--- 功能模块
---=========================================================================

--Card 稀有度
---@class CardRarity
CardRarity =
{
    SSR = "SSR",--全称为superior super rare，特级超稀有。一般为集换式卡牌游戏最高稀有等级。
    SR = "SR",  --Super Rare 超稀有（一般低于）
    R = "R",    --Rare稀有（一般作为协战点/友情/助战点能抽到的稀有度上限）
    N = "N",    --Normal普通（最常见最容易到手的稀有度级别
}

--DrawCardState 抽卡状态
---@class DrawCardState
DrawCardState =
{
    New = 0,
    Owned = 1,
}

--DrawCardState 抽卡类型
---@class DrawCardType
DrawCardType =
{
    Limit_Single = 0,  --限定单次
    Normal_Single = 1, --单次
    Normal_Series = 2, --连续多次
}

---@class BattleType
BattleType =
{
    Guide = 0, --新手引导战斗
    Trunk_Normal = 1, --主线剧情(普通)
    Trunk_Hard = 2, --主线剧情(困难)
    PVP_JJC = 3, --pvp 竞技场
}

--卡牌的状态
---@class CardState
CardState = {
    Normal = 1,     --空闲
    GridBattle = 2, --战斗战斗
    IdleBattle = 4, --放置战斗
}


-- 冒险事件类型
---@class IconType
IconType = {
    Item = "Item",    --道具Icon
    Avatar = "Avatar",    --英雄头像Icon
}

-- 冒险事件类型
---@class AdventureEventType
AdventureEventType = {
    FaceStrongEnemy = "FaceStrongEnemy",    --面对强敌
    Lunch = "Lunch",                        --午后大餐
}

-- 冒险事件进度类型
---@class AdventureEventProcessType
AdventureEventProcessType = {
    Ready = 1,          -- 未派遣探索阶段
    Starting = 2,       -- 探索中
    End = 3,            -- 探索结束，等待结算
}

-- 冒险事件结束后触发的事件
---@class AdventureEventAfterEventType
AdventureEventAfterEventType = {
    Normal = "Normal",                          -- 通用结算
    BossProposalEvent = "BossProposalEvent",    -- boss修罗场事件
}

---=========================================================================
--- 战斗相关
---=========================================================================

--游戏战斗模式
---@class BattleMode
BattleMode =
{
    City = "City",          --城镇非战斗模式
    Idle = "Idle",          --放置战斗挂机模式
    Grid = "Grid",          --九宫格战斗挂机模式
    Camp = "Camp",          --营地挂机模式
    PVE = "PVE",          --营地挂机模式
    PVP = "PVP",          --营地挂机模式
}



---@class BattleUnitType
BattleUnitType =
{
    Hero        = "Hero",       --英雄
    Monster     = "Monster",    --怪物
    NPC         = "NPC",        --NPC
    Collect     = "Collect",    --被采集
    Broken      = "Broken",     --可破坏物体
    Trap        = "Trap",       --陷阱
    Supply      = "Supply",     --补给物品
}

--包围圈间隔
AroundGap = {16,18,22,30,46,50}

-- 战斗中的一些显示表现
SomethingType = {
    Skill = 1,      -- 技能名飘动
    Buff = 2,       -- Buff效果飘动
}



HurtType = {
    Normal = 1,         -- 普通伤害
    Crit = 2,           -- 暴击伤害
    Miss = 3,           -- 闪避文字
    NormalNianYa = 4,   -- 普攻碾压
    CritNianYa = 5,     -- 暴击碾压
    Cure = 6,           -- 加血治疗
}

ResType =
{
    Gold = 2,
    Diamond = 4,
}

AnimType =
{
    Normal = "Normal",
    Manual = "Manual",
}

ResIcon =
{
    [ResType.Gold] = "Atlas/ResourceIcon/icon_coin_01.png",
    [ResType.Diamond] = "Atlas/ResourceIcon/icon_rainbowstone.png",
}

Prefabs =
{
    LayoutGrid = "Prefabs/Common/LayoutGrid.prefab",--布阵的格子
    BattleUnitHUD = "Prefabs/UI/Battle/BattleUnitHUD.prefab",
    FloatNumber = "Prefabs/UI/Battle/FloatNumber.prefab",
}


BubbleType =
{
    Happy = "Happy",        --高兴
    Amazing = "Amazing",    --惊讶
    Dizzy = "Dizzy",        --晕
    Angry = "Angry",        --生气
    Heart = "Heart",        --爱心
    HeartFly = "HeartFly",  --飘爱心
    HeartBreak = "HeartBreak",  --心碎
    Heart2 = "Heart2",        --爱心2
    Scare = "Scare",         --害怕
    Help = "Help",           --呼救
    Tired = "Tired",         --疲劳
    Vitality = "Vitality",   --元气
}

---@class AvatarType
AvatarType =
{
    Hero        = "Hero",       --英雄
    Monster     = "Monster",    --怪物
    NPC         = "NPC",        --NPC
    Collect     = "Collect",    --被采集
    Broken      = "Broken",     --可破坏物体
    Trap        = "Trap",       --陷阱
    Supply      = "Supply",     --补给物品
}
NpcFeature =
{
    ItemBusinessman = "ItemBusinessman",            --道具商人
    WeaponBusinessman = "WeaponBusinessman",        --武器商人
    ArmorBusinessman = "ArmorBusinessman",          --防具商人
    GodOfficer = "GodOfficer",                      --神官
}

---@class AttrType 属性类型
AttrType =
{
    Atk = 1,        -- 攻击
    Def = 2,        -- 防御
    Hp = 3,         -- 血量
    Crit = 4,       -- 暴击
}

---@class ItemType
ItemType =
{
    Item = 1,           -- 道具
    Equip = 2,          -- 装备
    Fragment = 3,       -- 碎片
    Task = 4,           -- 任务
}

---@class ItemSubType
ItemSubType =
{
    Exp = "Exp",                        -- 经验道具
    SwapTicket = "SwapTicket",          -- 扫荡券
    Stone = "Stone",                    -- 强化石
    Gift = "Gift",                      -- 礼物
    DrawCardTicket = "DrawCardTicket",  -- 抽卡券
    Equip = "Equip",                    -- 装备
    EquipFragment = "EquipFragment",    -- 装备碎片
}

--技能循环
---@class SkillLoop
SkillLoop = {"Normal","Normal","Skill2","Normal","Skill1"}

SkillType =
{
    Normal = "Normal",      --普攻
    Skill = "Skill",        --魔法技能
    Skill1 = "Skill1",        --魔法技能1
    Skill2 = "Skill2",        --魔法技能2
    UB = "UB",        --UB技能(大招)
    Passive = "Passive",    --被动技能
    Dig = "Dig",            --采集
}

---@class PassiveParamType 被动技能参数枚举
PassiveParamType =
{
    -- 属性增减
    Atk = "atk",                    -- 加攻
    Def = "def",                    -- 加防
    Crit = "crit",                  -- 加暴击
    Hp = "hp",                      -- 加血量
    AtkP = "atkP",                  -- 加攻（百分比）
    DefP = "defP",                  -- 加防（百分比）
    HpP = "hpP",                    -- 加血量（百分比）

    -- 特殊
    Berserker = "berserker",        -- 狂战技能(血越少攻越高)
}

SkillRangeType =
{
    NoRange = "NoRange",
    ShotRange = "ShotRange",
    LongRange = "LongRange",
    WaitRange = "WaitRange",
    CircleRange = "CircleRange",
    ConeRange = "ConeRange",
    RectRange = "RectRange",
}

--造成的效果
CauseEffect =
{
    RollingDodge            = "RollingDodge",               --触发敌方闪避
    Warning                 = "Warning",                    --触发预警
    Break                   = "Break",                      --触发敌方施放打断技能
}

--触发阶段
TriggerPhase =
{
    Any = "Any",                      --任何时候
    SkillPreUse = "SkillPreUse",      --技能使用之前
    SkillAccount = "SkillAccount",    --技能结算时
    SkillAfterUse = "SkillAfterUse",  --技能使用后
}

ShapeType =
{
    Circle = "Circle",      --圆形
    Cone = "Cone",          --锥形
    Rect = "Rect",          --矩形
}

---@class EffectMoveType 特效移动类型
EffectMoveType =
{
    FixedSource         = "FixedSource",
    FixedTarge          = "FixedTarge",
    FollowSource        = "FollowSource",
    FollowTarge         = "FollowTarge",
    FlySrc2Target       = "FlySrc2Target",
    FlyPos2Pos          = "FlyPos2Pos",
    FlyPos2Target       = "FlyPos2Target",
    FlySrc2Pos           = "FlySrc2Pos",
}

AreaType =
{
    Normal = "Normal", --普通怪物
    WayPoint = "WayPoint", --路点
    Summon = "Summon", --召唤怪物
    Boss = "Boss",     --Boss
    TeamBoss = "TeamBoss",      --组队Boss
}

WaveType =
{
    Init = "Init",    --初始就刷新
    Summon = "Summon", --召唤
    Trigger = "Trigger", --触发刷新
    AllDead = "AllDead", --上一波全部死亡
}

--出生模式
---@class WaveBornMode
WaveBornMode =
{
    BornEffect = "BornEffect",
    RightNow = "RightNow",
    WaitBorn = "WaitBorn",
}

WaveLoopType =
{
    Reverse = "Reverse",    --折返式
    Cycle = "Cycle"      --环形
}

---@class WayPointType
WayPointType =
{
    Walk = "Walk",    --普通行走
    Jump = "Jump",      --跳跃
    Obstruct = "Obstruct",      --障碍物
}

---@class SummonType
SummonType =
{
    Normal = "",
    Monster = "Monster",
    Collect = "Collect",
}

MonsterQuality =
{
    Normal = 1, --普通小怪
    Elite = 2, --精英
    Boss = 3, --Boss
}

---@class AccountType
AccountType =
{
    Multi = "Multi",  --AOE
    Single = "Single", --单体
    Performance = "Performance", --按表现来结算
}

AccountRange =
{
    None = "None",
    Front = "Front"   --前方180度内所有单位
}

SignetType =
{
    Dodge = "Dodge",  --被标记未闪避
}


-- 残影效果类型
GhostEffectType =
{
    Ghost = 1,      --幻影效果
    XRay = 2,       --轮廓光效果
}

--剧情对话位置
PlotPos = {}
PlotPos.ModileCenter  = "ModileCenter"
PlotPos.Left    = "Left"
PlotPos.Right   = "Right"
PlotPos.Center  = "Center"
PlotPos.Full    = "Full"

PlotOption = {}
PlotOption.Next  = "next"
PlotOption.Jump  = "jump"
PlotOption.Custom  = "custom"


--buff分组类型
BufferGroup =
{
    Default     = "Default",    --默认
    Dizzy       = "Dizzy",      --眩晕
    Restore     = "Restore",    --恢复
    Bleeding    = "Bleeding",   --流血
}

StoreType =
{
    WeaponStore = 1,
    ArmorStore = 2,
}

-- 掉落表现类型
DropType =
{
    blowout = "blowout",
}

--表现类型
PerformanceType =
{
    FallingDown     = "FallingDown",  --降落
    RollingDodge    = "RollingDodge",  --闪避
    Warning         = "Warning",  --预警
    SkillSing       = "SkillSing",  --吟唱
    ShowEmoji       = "ShowEmoji",  --显示表情符号
    Dizzy           = "Dizzy",  --眩晕
    Attenuate       = "Attenuate",  --衰减
    Gain            = "Gain",  --增益
    Recover         = "Recover",  --恢复
    SkyHit          = "SkyHit",  --浮空
}

--表现模式
PerformanceMode =
{
    Normal     = "Normal",  --普通模式
    Buffer    = "Buffer",  --buffer模式
}


--一些特殊状态的名字
---@class StateName
StateName = {}
StateName.StandBy       = "StandBy"
StateName.Moving        = "Moving"
StateName.Following     = "Following"
StateName.Attacking     = "Attacking"
StateName.Singing       = "Singing"
StateName.Dodge         = "Dodge"
StateName.Dead          = "Dead"
StateName.Rush          = "Rush"
StateName.RushHit       = "RushHit"
StateName.Dizzy         = "Dizzy"
StateName.SkyHit        = "SkyHit"
StateName.Forzen        = "Forzen"
StateName.PullOver      = "PullOver"
StateName.PushAway      = "PushAway"
StateName.FollowTarget  = "FollowTarget"
StateName.HitBack       = "HitBack"
--状态类型
StateType =
{
    Private = "Private",    --主动触发
    Public = "Public",      --被动触发
}

--被动触发操作枚举
---击退，眩晕，冰冻，浮空，占位，占位，占位，占位
PublicStateOperation = {}
PublicStateOperation.HitBack    = 1 --击退
PublicStateOperation.Dizzy      = 2 --眩晕
PublicStateOperation.Forzen     = 3 --冰冻
PublicStateOperation.SkyHit     = 4 --浮空

--操作枚举
---攻击（施法）,移动,作为攻击目标,作为结算目标,闪避,击退,浮空,冲锋,冲撞
Operation = {}
Operation.Attack    = 1 --攻击
Operation.Move      = 2 --移动
Operation.BeSelect  = 3 --被选择为攻击对象
Operation.BeAccount = 4 --被选择为结算对象
Operation.Dodge     = 5 --闪避
Operation.HitBack   = 6 --击退
Operation.SkyHit    = 7 --浮空
Operation.Rush      = 8 --冲锋
Operation.RushHit   = 9 --冲撞
Operation.PullOver     = 10 --聚拢
Operation.PushAway     = 11 --推开
Operation.FollowTarget = 12 --跟随目标

--替换模式
ReplaceMode =
{
    Forbid = "Forbid",          -- 禁止替换
    Replace = "Replace",        -- 直接替换
    Additive = "Additive",      -- 叠加
    Update  = "Update",         -- 更新时间
    Together = "Together",      -- 共存
    TimeFirst = "TimeFirst",    -- 对比时间
}

--计算符号
OperationSymbol =
{
    percent = "percent" --百分比
}

--属性字段名
AttrField =
{
    hp = "hp",
    atk = "atk",
    def = "def"
}

--章节关卡类型
CheckPointType =
{
    Normal = "Normal",      -- 普通关卡
    Resource = "Resource",      -- 资源点
}
--PieceItem类型
PieceItemType =
{
    Boom = "Boom",      -- 爆炸类型碎片，销毁不增加资源
    Normal =  "Normal",      -- 正常资源类型
}
--PieceItem类型

--回合模式
---@class RoundMode
RoundMode =
{
    Auto = "Auto",      --自动
    Manual = "Manual",  --手动
}

---@class Money
Money =
{
    GameMoney   = 1,    --游戏币
    PayMoney    = 2,    --充值币
    FreeMoney   = 3,    --免费币
    FragmentStone   = 4,    --兑换石
}
local GameConst = {}
return GameConst