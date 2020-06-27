---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2018/6/10 20:56
---


-- --------------- [ 支撑系统定义 ] --------------- --
--- DOTween
---@class DOTween : DG.Tweening.DOTween
DOTween = DG.Tweening.DOTween
DOTween_Enum = {
    ---@type DG.Tweening.AutoPlay
    AutoPlay = DG.Tweening.AutoPlay,
    ---@type DG.Tweening.AxisConstraint
    AxisConstraint = DG.Tweening.AxisConstraint,
    ---@type DG.Tweening.Ease
    Ease = DG.Tweening.Ease,
    ---@type DG.Tweening.LogBehaviour
    LogBehaviour = DG.Tweening.LogBehaviour,
    ---@type DG.Tweening.LoopType
    LoopType = DG.Tweening.LoopType,
    ---@type DG.Tweening.PathMode
    PathMode = DG.Tweening.PathMode,
    ---@type DG.Tweening.PathType
    PathType = DG.Tweening.PathType,
    ---@type DG.Tweening.RotateMode
    RotateMode = DG.Tweening.RotateMode,
    ---@type DG.Tweening.ScrambleMode
    ScrambleMode = DG.Tweening.ScrambleMode,
    ---@type DG.Tweening.TweenType
    TweenType = DG.Tweening.TweenType,
    ---@type DG.Tweening.UpdateType
    UpdateType = DG.Tweening.UpdateType,
}
DOTween.defaultEaseType = DOTween_Enum.Ease.Linear

Hud = Framework.Hud

Screen = UnityEngine.Screen

--- Lua Framework
edp = EventDispatcher.New() --全局事件派发器
ListViewEvent = require("Betel.UI.ListViewEvent")
TableList = require("Betel.UI.TableList")
PositionList = require("Betel.UI.PositionList")
--ListExtend = require("Game.Modules.Common.View.ListExtend") ---@type Module.Common.View.ListExtend
ListItemRenderer = require("Betel.UI.ListItemRenderer")

--- Global Events
WorldEvents = require("Game.Modules.World.Events.WorldEvents")
PointerEvent = require("Game.Events.PointerEvent")
DragDropEvent = require("Game.Events.DragDropEvent")
ViewEvents = require("Game.Events.ViewEvents")

--- FastBehavior
--StateAction = FastBehavior.StateAction
StateMachine = FastBehavior.StateMachine
--StateNode = FastBehavior.StateNode
FastLuaBehavior = FastBehavior.FastLuaBehavior
smMgr = FastBehavior.StateMachineManager.GetInstance() --状态机
smMgr:Init()
smMgr.StateActionTimeout = 100

---Utils
StringUtil = require("Game.Core.Utils.StringUtil")
ObjectUtil = require("Game.Core.Utils.ObjectUtil")
Tools3D = require("Game.Core.Utils.Tools3D")
UITools = require("Game.Core.Utils.UITools")
Timer = require("Game.Core.Utils.Timer")
TimeUtil = require("Game.Core.Utils.TimeUtil")

--- UI Utils
Alert = require("Game.Modules.Common.View.Alert")
Tips = require("Game.Modules.Common.View.Tips")
NetModal = require("Game.Modules.Common.View.NetModal")
ImageHelper = require("Game.Modules.Common.View.ImageHelper")

---Global
World = require("Game.Modules.World.World")

---导航
navigation = require("Game.Modules.Lobby.View.Navigation").New()

FRAME_TIME = 1 / Application.targetFrameRate

-- [声音系统]
SoundPlayer = require("Game.Modules.Common.Sound.SoundPlayer").New()
SoundConfig = require("Game.Data.SoundConfig")
SoundPlayer:Init()
--

--

-- --------------- [ 项目自定义 ] --------------- --

--Plot = require("Game.Modules.Plot.Scripts.Plot")
--GuideLine = require("Game.Modules.Common.Effect.GuideLine")
--PerformancePlayer = require("Game.Modules.World.Performances.PerformancePlayer")

---Utils
Convert     = require("Game.Modules.Common.Utils.Convert")
Layers      = require("Game.Modules.Common.Utils.Layers")
Convert     = require("Game.Modules.Common.Utils.Convert")
Math3D      = require("Game.Modules.Common.Utils.Math3D")
File        = require("Game.Modules.Common.Utils.File")
Tool        = require("Game.Modules.Common.Utils.Tool")
TimeConvert = require("Game.Modules.Common.Utils.TimeConvert")
PoolFactory = require("Game.Modules.Common.Pools.PoolFactory")
BezierUtils = require("Game.Modules.Common.Utils.BezierUtils")
GridUtils   = require("Game.Modules.Common.Utils.GridUtils")
BattleUtils = require("Game.Modules.Battle.Utils.BattleUtils")
LuaReflectHelper = require("Game.Modules.Common.Utils.LuaReflectHelper")

---Config
--Config = require("Game.Data.Config")
GameConst = require("Game.Config.GameConsts")
StrategyConsts = require("Game.Modules.Battle.Behaviors.Strategy.StrategyConsts")
--BehaviorUtils = require("Game.Modules.World.Behaviors.BehaviorUtils")
--Language = require("Game.Data.Languages." .. Config.language)

---Static Data
SkillConfig         = require("Game.Data.SkillConfig")
AvatarConfig        = require("Game.Data.AvatarConfig")
--EffectConfig        = require("Game.Data.EffectConfig")
AccountConfig      = require("Game.Data.AccountConfig")
--PlotConfig          = require("Game.Data.PlotConfig")
BattleConfig        = require("Game.Data.BattleConfig")
BattleUnitConfig    = require("Game.Data.BattleUnitConfig")
BattleSceneConfig   = require("Game.Data.BattleSceneConfig")
CheckPointConfig    = require("Game.Data.CheckPointConfig")
--CameraShakeConfig   = require("Game.Data.CameraShakeConfig")
--BufferConfig        = require("Game.Data.BufferConfig")
PerformanceConfig   = require("Game.Data.PerformanceConfig")
--StateConfig         = require("Game.Data.StateConfig")
CardConfig          = require("Game.Data.CardConfig")
--ItemConfig          = require("Game.Data.ItemConfig")
--AdventureEventConfig = require("Game.Data.AdventureEventConfig")
--AdventureEventAfterEventConfig = require("Game.Data.AdventureEventAfterEventConfig")
--PathConfig        = require("Game.Data.PathConfig")
--StageConfig        = require("Game.Data.StageConfig")
--ChapterConfig        = require("Game.Data.ChapterConfig")


---3rd
--AStarUtils = require("Game.Modules.Common.Utils.AStarUtils")
--MoveUtils = require("Game.Modules.Common.Utils.MoveUtils")
--Live2D = require("live2d.Live2D")
--Live2D.init();


---对象池
PoolObjectProxy = require("Game.Modules.Common.Pools.PoolObjectProxy")
BattleItemVoPool    = PoolObjectProxy.New(require("Game.Modules.Battle.Vo.BattleUnitVo"))
--HeroVoPool      = PoolObjectProxy.New(require("Game.Modules.World.Vo.HeroVo"))
--MonsterVoPool   = PoolObjectProxy.New(require("Module.World.Vo.MonsterVo"))
SkillVoPool     = PoolObjectProxy.New(require("Game.Modules.Battle.Vo.SkillVo"))
AccountContextPool = PoolObjectProxy.New(require("Game.Modules.Battle.Contexts.AccountContext"))
--AttributePool    = PoolObjectProxy.New(require("Module.World.Vo.Attribute")
--Icon = require("Game.Modules.Common.Icon.Icon")
--Star = require("Game.Modules.Common.Star.Star")
--WorldIcon = require("Game.Modules.Common.Icon.WorldIcon")