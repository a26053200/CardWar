---
--- Generated by Tools
--- Created by zheng.
--- DateTime: 2020-06-21-22:19:06
---

local BaseMediator = require("Game.Core.Ioc.BaseMediator")
---@class Game.Modules.CheckPoint.View.CheckPointInfoMdr : Game.Core.Ioc.BaseMediator
---@field checkPointModel Game.Modules.CheckPoint.Model.CheckPointModel
---@field roleModel Game.Modules.Role.Model.RoleModel
---@field battleConfigModel Game.Modules.BattleConfig.Model.BattleConfigModel
---@field checkPointService Game.Modules.CheckPoint.Service.CheckPointService
---@field battleService Game.Modules.Battle.Service.BattleService
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

    local starBar = self.gameObject:FindChild("StarBar")
    for i = 1, starBar.transform.childCount do
        local starImg = starBar.transform:GetChild(i - 1).gameObject:GetImage()
        starImg.sprite = UITools.GetSprite(starImg.gameObject, i <= self.section.star and 1 or 0)
    end

    self:UpdateView()
end


function CheckPointInfoMdr:UpdateView()
    self.textStrength.text = self.section.checkPointData.strength .. "/" .. self.roleModel.roleInfo.curStrength
    if self.section.checkPointData.maxPassNum == 0 then
        self.textTimes.text = "∞"
    else
        self.textTimes.text = self.section.passNum .. "/" .. self.section.checkPointData.maxPassNum
    end
end

function CheckPointInfoMdr:On_Click_BtnEnter()
    self.battleConfigModel.battleType = BattleType.Trunk_Normal
    navigation:Push(ViewConfig.BattleConfig)
end

function CheckPointInfoMdr:On_Click_BtnCancel()
    navigation:Pop(ViewConfig.CheckPointInfo)
end

function CheckPointInfoMdr:On_Click_BtnRecord()
    navigation:Push(ViewConfig.CheckPointReport)
end

return CheckPointInfoMdr
