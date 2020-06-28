---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2020/4/18 23:10
--- 标准的表现
---

local PerformanceBase = require("Game.Modules.Battle.Performances.PerformanceBase")
---@class Game.Modules.Battle.Performances.Standard : Game.Modules.Battle.Performances.PerformanceBase
---@field New fun(avatar: Game.Modules.World.Items.BattleUnit):Game.Modules.Battle.Performances.Standard
---@field accountContextList table<number, Game.Modules.World.Contexts.AccountContext>
---@field accounts table<number, AccountInfo>
---@field accountCount number
---@field animCount number
local Standard = class("Game.Modules.Battle.Performances.Standard", PerformanceBase)

function Standard:Ctor(battleUnit, performanceInfo)
    Standard.super.Ctor(self, battleUnit, performanceInfo)
    self.sequenceOver = false
    self.accountContextList = {}
    self.accountCount = 0
    self.animCount = 0
end

---@param sequence DG.Tweening.Sequence
function Standard:OnBeginPerformance(sequence)
    Standard.super.OnBeginPerformance(self, sequence)

    self.skillVo = self.args[1] ---@type Game.Modules.Battle.Vo.SkillVo

    self:StartCoroutine(function()
        self.accounts = self.performanceInfo.accounts
        self:OnProcessStart()
        for i = 1, self.performanceInfo.times do
            self:Process()
            coroutine.wait(self.performanceInfo.interval / self.battleUnit.context.battleSpeed)
        end
        while self.accountCount < self.performanceInfo.times * #self.accounts do
            coroutine.step(1)
        end
        while self.animCount < self.performanceInfo.times do
            coroutine.step(1)
        end
        self.sequenceOver = true
        self:OnProcessEnd()
    end)
    return true
end

--开始
function Standard:OnProcessStart()

end

function Standard:Process()
    if self.performanceInfo.accountType == AccountType.Single then
        --self.battleUnit:PlayIdle()
        self.battleUnit.accountCtrl:AccountProgress(self.performanceInfo.animInfo,function()
            for i = 1, #self.accounts do
                self:DoAccount(self.accounts[i])
            end
        end)
    else
        ---@param account AccountInfo
        self.battleUnit.accountCtrl:MultiAccountProgress(self.performanceInfo.animInfo, self.accounts, function(account)
            self:DoAccount(account)
        end)
    end
    self.battleUnit.animCtrl:PlayAnimInfo(self.performanceInfo.animInfo,Handler.New(function()
        self.animCount = self.animCount + 1
    end))
end


---@param account AccountInfo
function Standard:DoAccount(account)
    local accountContext = World.CreateAccountContext(self.skillVo, self.battleUnit, account)
    --local effect = self.avatar.effectWidget:Play(self.skillVo.skillInfo.effect,nil, nil , startPosList[i])
    --effect.tagPos = destPosList[i]
    --effect.minDistance = 0
    --accountContext.effect = effect
    accountContext:Start(self.performanceInfo.gridSelect)
    accountContext:ExecuteAccount()
    self.accountCount = self.accountCount + 1
    table.insert(self.accountContextList, accountContext)
    --self.lastEffect = effect
end

function Standard:OnProcessEnd()

end

--重写阻塞函数
---@param sequence DG.Tweening.Sequence
function Standard:OnWaitPerformance(sequence)
    --等待开始阶段结束
    while not self.sequenceOver do
        coroutine.step(1)
    end
end

function Standard:Dispose()
    Standard.super.Dispose(self)
    for i = 1, #self.accountContextList do
        self.accountContextList[i]:End()
    end

end

return Standard