---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhengnan.
--- DateTime: 2018/11/15 15:42
--- 资源对象池 (暂时没有限制最大数量,超过数量时会给与警告)
---

---@class Game.Modules.Common.Pools.AssetPool
---@field New fun(prefab:string|UnityEngine.GameObject, parent:UnityEngine.Transform, initNum:number):Game.Modules.Common.Pools.AssetPool
---@field pool List
---@field delList List
---@field orgObj UnityEngine.GameObject
---@field isDisposed boolean 对象池是否被释放
local AssetPool = class("Game.Modules.Common.Pools.AssetPool")

--构造函数
---@param initNum number @ 初始话数量
---@param parent UnityEngine.Transform @ 对象预制路径
---@param prefab string | UnityEngine.GameObject @ 对象预制路径
function AssetPool:Ctor(prefab, parent, initNum)
    self.isDisposed = false
    self.pool = List.New()
    self.delList = List.New()
    self.parent = parent
    if type(prefab) == "string" then
        self.orgObj = Res.LoadAsset(prefab)
        self.orgObj.name = File.GetFileNameWithoutExtension(prefab)
    else
        self.orgObj = prefab
        self.orgObj:SetActive(false)
    end
    self.initNum = initNum and Mathf.Max(1,initNum) or 1
    for i = 1, initNum do
        self:ExpandPoolObj()
    end
end

--池对象扩容
function AssetPool:ExpandPoolObj()
    local itemObj = GameObject.Instantiate(self.orgObj)
    itemObj.name = self.orgObj.name
    itemObj.transform:SetParent(self.parent)
    itemObj.transform.localPosition = self.orgObj.transform.localPosition
    --itemObj.transform.localScale    = self.orgObj.transform.localScale
    itemObj.transform.localRotation = self.orgObj.transform.localRotation
    self:Store(itemObj)
end

--池对象扩容
function AssetPool:ExpandPoolObjNum(num)
    self.initNum = self.initNum + num
    for i = 1, num do
        self:ExpandPoolObj()
    end
end

--回收对象
---@param obj UnityEngine.GameObject
---@return boolean
function AssetPool:Store(obj)
    if self.isDisposed then
        logError(string.format("This pool %s had dispose!", self.orgObj.name));
        return false
    end
    if isnull(obj) then
        --在销毁之前存回给对象池
        logError("Can not destroy pool object, you must be store it")
        return false
    end
    if self.pool:Contain(obj) then
        --在销毁之前存回给对象池
        logWarning("重复添加对象."..self.orgObj.name)
    else
        --LuaHelper.SetParent(obj.transform, self.parent)
        obj.transform:SetParent(self.parent)
        --下面两种隐藏方式性能有待测试
        obj.transform.localPosition = Vector3.New(0,0,99999)
        obj:SetActive(false)
        obj.name = self.orgObj.name
        self.pool:Push(obj)
        self.delList:Remove(obj)
    end
    return true
end

--获取池对象
---@return UnityEngine.GameObject
function AssetPool:Pop()
    if self.isDisposed then
        logError(string.format("This pool %s had dispose!", self.orgObj.name));
        return
    end
    if self.pool:Size() == 0 then
        self.initNum = self.initNum + 1
        --logWarning("[Warnning]ObjectPool is overflow! -- " .. self.orgObj.name .. " new num:" .. self.initNum)
        self:ExpandPoolObj()
    end
    local itemObj = self.pool:Pop()
    --下面两种显示方式性能有待测试
    --itemObj.transform.localPosition = Vector3.zero
    itemObj:SetActive(true)

    itemObj.transform.localPosition = self.orgObj.transform.localPosition
    --itemObj.transform.localScale    = self.orgObj.transform.localScale
    itemObj.transform.localRotation = self.orgObj.transform.localRotation
    self.delList:Push(itemObj)
    return itemObj
end

--释放所有池对象
function AssetPool:Dispose()
    self.isDisposed = true
    for i = 1, self.pool:Size() do
        Destroy(self.pool[i])
    end
    for i = 1, self.delList:Size() do
        Destroy(self.delList[i])
    end
    self.pool:Clear()
    self.delList:Clear()
end

return AssetPool