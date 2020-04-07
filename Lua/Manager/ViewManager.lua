---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2018/6/20 16:21
--- 视图管理d
---

local LuaMonoBehaviour = require('Betel.LuaMonoBehaviour')
local IocBootstrap = require("Game.Core.Ioc.IocBootstrap")
---@class Game.Manager.ViewManager : Betel.LuaMonoBehaviour
---@field ioc Game.Core.Ioc.IocBootstrap
---@field scene Game.Modules.World.Scenes.BaseScene
---@field viewCache table<string, Game.Core.Ioc.BaseMediator>
---@field viewList List | table<number, Game.Core.Ioc.BaseMediator>
---@field uiLayers table<string, UnityEngine.Transform>
---@field uiCanvas UnityEngine.Canvas
---@field uiCamera UnityEngine.Camera
local ViewManager = class("ViewManager",LuaMonoBehaviour)

function ViewManager:Ctor()
    self.viewCache = {}
    self.viewList = List.New()
    self.uiLayers = {}

    local prefab = Res.LoadPrefab("Prefabs/UI/Common/UICanvas.prefab")
    self.uiCanvas = Instantiate(prefab)
    self.uiCanvas.name = "[UICanvas]"
    self.uiCamera = self.uiCanvas:FindChild("UICamera"):GetComponent(typeof(UnityEngine.Camera))
    self.uiCanvas = self.uiCanvas:GetComponent(typeof(UnityEngine.Canvas))
    dontDestroyOnLoad(self.uiCanvas.gameObject)
    ViewManager.super.Ctor(self, self.uiCanvas.gameObject)
end

function ViewManager:Init()
    self.ioc = IocBootstrap.New()
    self.ioc:Launch()
end

---@return UnityEngine.Transform
function ViewManager:GetUILayer(layerName)
    local layer = self.uiLayers[layerName]
    if layer == nil then
        layer = self.uiCanvas.gameObject:FindChild(layerName)
        if not layer then
            logError("there is no layer named " .. layerName)
        else
            self.uiLayers[layerName] = layer
        end
    end
    return layer.transform
end
---@param scene Game.Modules.World.Scenes.BaseScene
function ViewManager:SetScene(scene)
    self.scene = scene
end

---@param viewInfo Game.Manager.ViewInfo
function ViewManager:LoadView(viewInfo)

    self:DoLoadViewCo(viewInfo)
end

---@param viewInfo Game.Manager.ViewInfo
function ViewManager:DoLoadViewCo(viewInfo)
    if viewInfo == nil then
        logError("'viewInfo' param is nil")
        return
    end

    if viewInfo.status == nil or viewInfo.status == ViewStatus.Unloaded then
        viewInfo.status = ViewStatus.Loading
        self:LoadViewPrefab(viewInfo,function (go)
            self:CreateView(viewInfo,go)
            viewInfo.status = ViewStatus.Loaded
        end)
    else
        if viewInfo.status == ViewStatus.Loading or
            viewInfo.status == ViewStatus.Unloading or
            viewInfo.status == ViewStatus.Loaded then
            logError("View {0} status is {1} ,you can't load this view right now!",viewInfo.name, viewInfo.status)
        end
    end
end

--重新打开
---@param viewInfo Game.Manager.ViewInfo
function ViewManager:ReloadView(viewInfo)
    if self:isUnloaded(viewInfo) then
        self:LoadView(viewInfo)
    else
        self:UnloadView(viewInfo)
        local co
        co = self:StartCoroutine(function()
            coroutine.step(1)
            while not self:isUnloaded(viewInfo) do
                coroutine.step(1)
            end
            self:LoadView(viewInfo)
            coroutine.stop(co)
        end)
    end
end

---@param viewInfo Game.Manager.ViewInfo
function ViewManager:UnloadView(viewInfo, callback)
    if viewInfo.status == ViewStatus.Loaded then
        local mdr = self.viewCache[viewInfo.name]
        if mdr then
            self.viewCache[viewInfo.name] = nil
            self.viewList:Remove(mdr)
            mdr:DoRemove(function()
                Destroy(mdr.gameObject)
            end,function ()
                viewInfo.status = ViewStatus.Unloaded
                ViewEvents.DispatchEvent({type = ViewEvents.Unloaded, viewInfo = viewInfo})
            end)
            --if not mdr.isEnableMonoBehaviour then
            --    mdr:OnDestroy()
            --end

            local co
            co = self:StartCoroutine(function()
                coroutine.step(1)
                while not self:isUnloaded(viewInfo) do
                    coroutine.step(1)
                end
                coroutine.stop(co)
                if callback then
                    callback()
                end
            end)
        else
            --logError("View {0} has not loaded", viewInfo.name)
        end
    else
        --logError("View {0} status is {1} ,you can't unload this view",viewInfo.name, viewInfo.status)
    end
end

---@param viewInfo Game.Manager.ViewInfo
---@param callback function
function ViewManager:LoadViewPrefab(viewInfo,callback)
    Res.LoadPrefabAsync(viewInfo.prefab, function(prefab)
        if prefab then
            local go = GameObject.Instantiate(prefab)
            callback(go)
        end
    end)
end

---@param viewInfo Game.Manager.ViewInfo
---@param go UnityEngine.GameObject
function ViewManager:CreateView(viewInfo,go)
    local mdrType = self.ioc.mediatorContext:GetMediator(viewInfo.name)
    if mdrType == nil then
        logError("view:'{0}' has not register", viewInfo.name)
        return
    end
    local mdr = mdrType.New() ---@type Game.Core.Ioc.BaseMediator
    if viewInfo ~= ViewConfig.World then
        mdr.scene = self.scene
        mdr.uiCanvas = self.uiCanvas
        mdr.uiCamera =  self.uiCamera
        go.transform:SetParent(self:GetUILayer(mdr.layer))
    else
        dontDestroyOnLoad(go)
        go.name = "[World]"
        go.transform:SetParent(nil)
    end
    mdr.viewInfo = viewInfo
    mdr.gameObject = go
    mdr.transform = go.transform
    go.name = viewInfo.name .. " - [" ..go.name .. "]"
    local rect = go:GetRect()
    go.transform.localPosition = Vector3.zero
    if not isNull(rect) and rect.anchorMin == Vector2.New(0,0) and rect.anchorMax == Vector2.New(1,1) then
        --rect.anchorMin = Vector2.zero
        --rect.anchorMax = Vector2.one
        rect.sizeDelta = Vector2.zero
        rect.anchoredPosition = Vector2.zero
    end
    go.transform.localEulerAngles = Vector3.zero
    --go.transform.sizeDelta = Vector2.zero
    go.transform.localScale = Vector3.one

    self.ioc.binder:InjectSingle(mdr)
    if mdr.isEnableMonoBehaviour then
        mdr:AddLuaMonoBehaviour(go,"BaseMediator")
    else
        LuaHelper.AddLuaMonoBehaviour(go,"BaseMediator",BehaviourFun.Start,handler(mdr,mdr.Start))
        LuaHelper.AddLuaMonoBehaviour(go,"BaseMediator",BehaviourFun.OnDestroy,handler(mdr,mdr.OnDestroy))
    end

    log("View has loaded name:{0}, Enable MonoBehaviour:{1}", viewInfo.name,tostring(mdr.isEnableMonoBehaviour))
    self.viewCache[viewInfo.name] = mdr
    self.viewList:Add(mdr)

    ViewEvents.DispatchEvent({type = ViewEvents.Loaded, viewInfo = viewInfo})
end

---@param viewInfo Game.Manager.ViewInfo
---@return boolean
function ViewManager:isUnloaded(viewInfo)
    return viewInfo.status == nil or viewInfo.status == ViewStatus.Unloaded
end

---@param class Game.Core.BaseCommand
---@return Game.Core.BaseCommand
function ViewManager:CreateCommand(class)
    local cmd = class.New()
    self.ioc.binder:InjectSingle(cmd)
    cmd:OnInit()
    return cmd
end
return ViewManager