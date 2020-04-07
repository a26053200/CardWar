---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2019/10/28 16:48
--- 临时View基类 以后需要用Mediator 代替
---

local BaseMediator = require("Game.Core.Ioc.BaseMediator")

---@class View
---@field New fun(prefab:UnityEngine.GameObject | string, parent:string | UnityEngine.Transform, groupName:string, isAsync:boolean):View
---
---@field gameObject UnityEngine.GameObject
---@field transform UnityEngine.Transform | UnityEngine.RectTransform
---@field initShow boolean @ 初始化时是否直接显示（默认是否显示）。默认值：true
---@field visible boolean @ 是否已经显示
---@field destroyed boolean @ 是否已经被销毁
---
---@field _initialized boolean @ 是否已经初始化完成了
local View = class("View")

--
--- 构造函数
--- 参数详情可参考 Instantiate() 和 InstantiateAsync() 函数使用范例
--- 如果不使用 prefab 来创建 gameObject，或该 view 没有对应的 gameObject，请手动调用 OnInitialize() 函数
---@param prefab UnityEngine.GameObject | string @ -可选- 预设对象 或 预设路径
---@param parent string | UnityEngine.Transform @ -可选- 图层名称 或 父节点(Transform)
---@param groupName string @ -可选- 资源组名称。参数 prefab 为预设路径时，才需要传入该值。默认值为当前场景名称
---@param isAsync boolean @ -可选- 是否异步加载资源。默认：false
function View:Ctor(prefab, parent, groupName, isAsync)
    if prefab == nil then
        return -- 无需在该构造函数初始化
    end
    self.visible = true

    if isAsync then
        Res.LoadPrefab(prefab, function(prefabObj)
            self.gameObject = self:Instantiate(prefabObj, parent)
            self:OnInitialize()
            if self.visible then
                self:OnShow()
            end
        end)
    else
        self.gameObject = self:Instantiate(prefab, parent)
        self:OnInitialize()
        if self.visible then
            self:OnShow()
        end
    end
end

function View:Instantiate(prefab, parent)
    local go = Instantiate(prefab)
    if isString(parent) then
        go.transform:SetParent(vmgr:GetUILayer(parent))
    else
        go.transform:SetParent(parent)
    end
    go.transform.localEulerAngles = Vector3.zero
    --go.transform.sizeDelta = Vector2.zero
    go.transform.localScale = Vector3.one
    return go
end

function View:EnableDestroyListener(enabled)
    enabled = enabled == nil and true or enabled

    local go = self.gameObject

    if enabled then
        self.destroyBehaviour = LuaHelper.AddLuaMonoBehaviour(go,"View OnDestroy",BehaviourFun.OnDestroy,handler(self,self.OnDestroy))
        --AddEventListener(go, Event.DESTROY, self.OnDestroy, self)
    else
        if self.destroyBehaviour then
            Destroy(self.destroyBehaviour)
        end
        --RemoveEventListener(go, Event.DESTROY, self.OnDestroy, self)
    end
end

--
--- 初始化时（已创建 prefab 实例），并设置 self.gameObject
--- 注意：该函数只能被调用一次，子类可以在该函数内做一些初始化的工作。子类覆盖该函数时，记得调用 Class.super.OnInitialize(self)
function View:OnInitialize()
    if self.gameObject then
        self.transform = self.gameObject.transform
    end
end

--- 设置是否可见
---@param self View
---@param value boolean
function View:SetVisible(value)
    self.visible = value
    local go = self.gameObject
    if isnull(go) then
        self.gameObject = nil
    else
        go:SetActive(value)
    end

    if value then
        self:OnShow()
    else
        self:OnHide()
    end
end

--- 显示 gameObject
function View:Show()
    if not self.visible then
        self:SetVisible(true)
    end
end

--- 隐藏 gameObject
function View:Hide()
    if self.visible then
        self:SetVisible(false)
    end
end


--- 显示时
function View:OnShow()
end

--- 隐藏时
function View:OnHide()
end

--- self.gameObject 被销毁时
--- 子类重写 OnDestroy() 方法，将会自动调用 EnableDestroyListener() 设置监听
function View:OnDestroy()
    print("View:OnDestroy")
    self.destroyed = true
end
--- 销毁界面对应的 gameObject
---@param delay number @ -可选- 延时销毁（秒）。默认：nil，表示立即销毁
function View:Destroy(delay)
    self.destroyed = true
    Destroy(self.gameObject, delay)
end

return View