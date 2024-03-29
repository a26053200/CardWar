---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2020-06-14-20:33:51
---

local ItemVo = require("Game.Modules.Item.Vo.ItemVo")
local BaseService = require("Game.Core.Ioc.BaseService")
---@class Game.Modules.Item.Service.ItemService : Game.Core.Ioc.BaseService
---@field itemModel Game.Modules.Item.Model.ItemModel
local ItemService = class("ItemService",BaseService)

function ItemService:Ctor()
    
end

---@param roleId string
---@param callback fun()
function ItemService:getItemList(roleId, callback)
    self:HttpRequest(Action.ItemList, {roleId}, function(data)
        if self.roleModel.roleInfo.id == roleId then
            local itemList = List.New()
            for i = 1, #data.itemList do
                local itemVO = ItemVo.New(data.itemList[i])
                itemList:Add(itemVO)
            end
            self.itemModel.itemList = itemList
        end
        invoke(callback, data)
    end)
end

return ItemService
