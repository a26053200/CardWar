---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2020-06-21-22:19:06
---

local BaseMediator = require("Game.Core.Ioc.BaseMediator")
---@class Game.Modules.CheckPoint.View.CheckPointInfoMdr : Game.Core.Ioc.BaseMediator
---@field checkPointModel Game.Modules.CheckPoint.Model.CheckPointModel
---@field roleModel Game.Modules.Role.Model.RoleModel
---@field checkPointService Game.Modules.CheckPoint.Service.CheckPointService
---@field section Game.Modules.CheckPoint.Vo.SectionVo
local CheckPointInfoMdr = class("Game.Modules.CheckPoint.View.CheckPointInfoMdr",BaseMediator)


function CheckPointInfoMdr:Ctor()
    CheckPointInfoMdr.super.Ctor(self)
    self.layer = UILayer.LAYER_FLOAT
end

function CheckPointInfoMdr:OnInit()
    self.section = self.checkPointModel.currSection
    self.gameObject:GetText("Title/Text").text = self.section.checkPointData.name
    self.textStrength = self.gameObject:GetText("Right/GroupText/TextStrength")
    self.textTimes = self.gameObject:GetText("Right/GroupText/TextTimes")

    self:UpdateView()
end

function CheckPointInfoMdr:UpdateView()
    self.textStrength.text = self.section.checkPointData.strength .. "/" .. self.roleModel.roleInfo.curStrength
    if self.section.checkPointData.maxPassNum == 0 then
        self.textTimes.text = "oo"
    else
        self.textTimes.text = self.section.passNum .. "/" .. self.section.checkPointData.maxPassNum
    end
end

function CheckPointInfoMdr:On_Click_BtnCancel()
    vmgr:UnloadView(ViewConfig.CheckPointInfo)
end

function CheckPointInfoMdr:On_Click_BtnEnter()
    vmgr:LoadView(ViewConfig.ArrayEditor)
end

return CheckPointInfoMdr