---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2019/5/20 15:50
--- 状态机
---

local StateAction = require("Game.Modules.Common.Behavior.StateAction")

---@class Game.Modules.Common.Behavior.StateMachine
---@field New fun():Game.Modules.Common.Behavior.StateMachine
---@field currState Game.Modules.Common.Behavior.StateAction
---@field startTime number 开始时间
local StateMachine = class("Game.Modules.Common.Behavior.StateMachine")

local s_id = 1

function StateMachine:Ctor()

    self.id = s_id
    s_id = s_id + 1

    self.stateMap = {}
    self.state2DList = List.New() --状态二维表
    self.currState = nil
    self.currStateList = self.state2DList
    self.cycleOverCallback = nil --周期结束
    self.isDispose = false
    self.curr2DList = nil
end

function StateMachine:Run(cycleOverCallback)
    self.cycleOverCallback = cycleOverCallback
    self.currState = nil
    self.curr2DList = self.state2DList:Clone()
    --log("StateMachine:Run " .. s_id)
    AddEventListener(Event.Update, self.Update, self)
    self:NextState()
end

function StateMachine:Stop()
    self.currStateIndex = 0
    self.currState = nil
    RemoveEventListener(Event.Update, self.Update, self)
end

function StateMachine:BeginSelect()
    self.currStateList = List.New()
end

---@param stateAction Game.Modules.Common.Behavior.StateAction
function StateMachine:AppendState(stateAction)
    self.currStateList:Push(stateAction)
end

function StateMachine:EndSelect()
    self.state2DList:Push(self.currStateList)
    self.currStateList = self.state2DList
end

function StateMachine:NextState()
    if self.curr2DList:Size() == 0 then
        self.curr2DList = self.state2DList:Clone()
        if self.cycleOverCallback then
            self.cycleOverCallback()
        end
    end
    self.currState = nil
    local state = self.curr2DList:Shift()
    if state.__cname == StateAction.__cname then
        self.currState = state
    elseif state._cname == List._cname then
        --随机选择
        local randomIdxs = Tools.GetRandomArray(state:Size())
        for i = 1, #randomIdxs do
            if state[randomIdxs[i]]:CanExecute() then
                self.currState = state[randomIdxs[i]]
                break;
            end
        end
    else
        logError("State machine queue error!!!")
    end
    if self.currState then
        self.currState:Start()
    end
end

function StateMachine:Update()
    if self.currState then
        local state = self.currState
        local isOver = state:IsOver()
        if not state.execute then
            state.execute = true
            if state.node.OnEnter ~= nil then
                state.node.OnEnter:Execute(state)
            end
        end
        if isOver then
            self:NextState()
        end
    else
        --self:NextState()
    end
end

return StateMachine