---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2020-05-31-23:56:06
---

local BaseMediator = require("Game.Core.Ioc.BaseMediator")
---@class Game.Modules.Role.View.ResourceBarMdr : Game.Core.Ioc.BaseMediator
---@field roleModel Game.Modules.Role.Model.RoleModel
---@field roleService Game.Modules.Role.Service.RoleService
local ResourceBarMdr = class("Game.Modules.Role.View.ResourceBarMdr",BaseMediator)

function ResourceBarMdr:OnInit()
    self.roleInfo = self.roleModel.mainRoleInfo;

    self.gameObject:GetText("Status/GameMoney/Text").text = self.roleInfo.gameMoney
    self.gameObject:GetText("Status/FreeMoney/Text").text = self.roleInfo.freeMoney
    self.gameObject:GetText("Status/Exp/Text").text = self.roleInfo.curExp
    self.gameObject:GetText("Status/Sp/Text").text = self.roleInfo.curStrength .. "/" .. self.roleInfo.maxStrength

    self.exp = self:InitSlider("Status/Exp/Slider", 0, self.roleInfo.maxExp, self.roleInfo.curExp)
    self.sp = self:InitSlider("Status/Sp/Slider", 0, self.roleInfo.maxStrength, self.roleInfo.curStrength)
end


---@return UnityEngine.UI.Slider
function ResourceBarMdr:InitSlider(path, minValue, maxValue, value)
    local slider = self.gameObject:GetSlider(path)
    slider.minValue = minValue
    slider.maxValue = maxValue
    slider.value = value
    return slider
end

return ResourceBarMdr