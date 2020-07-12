---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2020/4/18 23:06
--- 结算控制器
---

local Widget = require("Game.Modules.Common.Components.Widget")
---@class Game.Modules.Battle.Components.AccountCtrl : Game.Modules.Common.Components.Widget
---@field New fun(battleUnit:Game.Modules.World.Items.BattleUnit):Game.Modules.Battle.Components.AccountCtrl
---@field battleUnit Game.Modules.World.Items.BattleUnit
---@field performanceList List | table<number, Game.Modules.Battle.Performances.PerformanceBase>
---@field deadItemList List | table<number, Game.Modules.World.Items.BattleUnit>
---@field overCallback Handler
local AccountCtrl = class("Game.Modules.Battle.Performances.AccountCtrl",Widget)

---@param battleUnit Game.Modules.World.Items.BattleUnit
function AccountCtrl:Ctor(battleUnit)
    self.battleUnit = battleUnit
    self.deadItemList = List.New()
end

---@param skillVo Game.Modules.Battle.Vo.SkillVo
---@param callback Handler
function AccountCtrl:Account(skillVo, callback)
    self.overCallback = callback
    self:StartCoroutine(function()
        self:OnAccountBegin(skillVo)
        self:OnAccountProcess(skillVo)
        self:OnAccountEnd()
    end)
end

---@param skillVo Game.Modules.Battle.Vo.SkillVo
function AccountCtrl:OnAccountBegin(skillVo)
    local performanceInfo = PerformanceConfig.Get(skillVo.skillInfo.performance)
    self.battleUnit.battleUnitVo:ActionRecoveryTP()
    self.battleUnit:SetHudVisible(false)
    self.targetCamp = BattleUtils.GetTargetCamp(performanceInfo.gridSelect, self.battleUnit)
    self.targetGridList = GridUtils.GetTargetCampAndGrids(performanceInfo.gridSelect,self.targetCamp, self.battleUnit)
    --获取站位
    local tagPos
    if self.targetGridList and #self.targetGridList > 0 then
        --设置选取效果
        self.battleUnit.context.battleLayout:SetAttackSelect(self.targetCamp, self.targetGridList, true)
        local tagPosGrids = self.targetGridList
        if performanceInfo.gridSelect == GridSelectType.Row then
            tagPosGrids = {1,4,9}
            local target = self:GetTarget(self.targetCamp, tagPosGrids)
            tagPos = GridUtils.GetTargetAttackPoint(target.gameObject,self.battleUnit.context.battleSceneInfo.layoutGridSize)
        elseif performanceInfo.gridSelect == GridSelectType.Current then
            local target = self:GetTarget(self.targetCamp, tagPosGrids)
            tagPos = GridUtils.GetTargetAttackPoint(target.gameObject,self.battleUnit.context.battleSceneInfo.layoutGridSize)
        elseif performanceInfo.gridSelect == GridSelectType.Col then
            tagPosGrids = LayoutIndex2Col[self.battleUnit.layoutIndex]
            local targetGrid = self.battleUnit.context.battleLayout:GetLayoutGridByIndex(self.targetCamp, tagPosGrids[1])
            tagPos = targetGrid.transform.position + -self.battleUnit.transform.forward * self.battleUnit.context.battleSceneInfo.layoutGridSize
        elseif performanceInfo.gridSelect == GridSelectType.All
                or performanceInfo.gridSelect == GridSelectType.Friend_Lowest
                or performanceInfo.gridSelect == GridSelectType.Friend_All then
            tagPos = self.battleUnit.context.battleLayout.center
        end
    else
        print("There is not any account target in battle area")
        tagPos = self.battleUnit.context.battleLayout.center
    end
    local moveOver = false
    self.battleUnit:PlayRun()
    self.battleUnit.transform:DOMove(tagPos, FRAME_TIME * 9 / self.battleUnit.context.battleSpeed):OnComplete(function()
        self.battleUnit:PlayIdle()
        moveOver = true
    end)
    while not moveOver  do
        coroutine.step(1)
    end
end

---@param skillVo Game.Modules.Battle.Vo.SkillVo
function AccountCtrl:OnAccountProcess(skillVo)
    local accountOver = false
    self.battleUnit.performancePlayer:Play(skillVo.skillInfo.performance,function()
        accountOver = true
    end, skillVo)
    while not accountOver  do
        coroutine.step(1)
    end
end

function AccountCtrl:OnAccountEnd()
    if self.overCallback then
        self.overCallback:Execute()
        self.overCallback = nil
    end
    self.battleUnit:SetHudVisible(true)
    --设置选取效果
    self.battleUnit.context.battleLayout:SetAttackSelect(self.targetCamp, self.targetGridList, false)
    for i = 1, self.deadItemList:Size() do
        self.deadItemList[i]:OnDead()
        self.deadItemList[i]:PlayDead()
    end
    self.deadItemList:Clear()
end

--检测死亡
---@param target Game.Modules.World.Items.BattleUnit
---@param skillVo Game.Modules.Battle.Vo.SkillVo
function AccountCtrl:OnCheckDead(skillVo, target)
    if target:IsDead() then
        local skillInfo = skillVo.skillInfo
        if not self.deadItemList:Contain(target) then
            self.deadItemList:Add(target)
        end
    end
end

---@param animInfo AnimInfo
function AccountCtrl:AccountProgress(animInfo, accountCallback)
    local animLength = self.battleUnit.animCtrl:GetAnimLength(animInfo.animName)
    self:CreateDelay(animInfo.accountPoint * self:GetAnimLength(animLength, animInfo), accountCallback)
end

---@param animInfo AnimInfo
---@param accounts table<number, AccountInfo>
function AccountCtrl:MultiAccountProgress(animInfo, accounts, accountCallback)
    local animLength = self.battleUnit.animCtrl:GetAnimLength(animInfo.animName)
    for i = 1, #accounts do
        self:CreateDelay(accounts[i].accountPoint * self:GetAnimLength(animLength, animInfo), function()
            accountCallback(accounts[i])
        end)
    end
end

---@param animInfo AnimInfo
function AccountCtrl:GetAnimLength(animLength, animInfo)
    return math.max(0.1,animLength / (animInfo.animSpeed * 1.5 * self.battleUnit.context.battleSpeed))
end

function AccountCtrl:DisplayHurt(hurtInfo, isHelpful)
    if isHelpful then
        self.battleUnit.battleUnitVo.curHp = math.min( self.battleUnit.battleUnitVo.curHp + hurtInfo.dam,  self.battleUnit.battleUnitVo.maxHp)
        self.battleUnit:DoHurt(hurtInfo)
    else
        self.battleUnit.battleUnitVo:DamageRecoveryTP(hurtInfo.dam)--恢复Tp
        self.battleUnit.battleUnitVo.curHp = math.max(0, self.battleUnit.battleUnitVo.curHp - hurtInfo.dam)
        self.battleUnit:DoHurt(hurtInfo)
        self.battleUnit:PlayIdle()
        self.battleUnit:PlayHit()
        --target.soundGroup:Play(skillInfo.hitSound)
    end
    --self:HurtPerformance(target, skillInfo, account)
end

---@param targetCamp Camp
---@param targetGridList table<number, number>
---@return Game.Modules.World.Items.BattleUnit
function AccountCtrl:GetTarget(targetCamp, targetGridList)
    local targetList = self.battleUnit.context.battleLayout:GetTargetList(targetCamp, targetGridList)
    local target = targetList[1]
    if #targetList > 0 then
        target = targetList[1]--有点攻击当前列的当前角色
    else --当前列没有就攻击阵营最前面的单位
        target = self.battleUnit.context.battleLayout:GetFirstGrid(targetCamp).owner
    end
    return target
end

function AccountCtrl:Dispose()
    AccountCtrl.super.Dispose(self)
end

return AccountCtrl