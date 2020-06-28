---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2019/1/10 0:17
---

---@class Action
---@field server string
---@field action string
---@field fields string
local Action = {}

---==================
--- 登陆相关
---==================
Action.LoginAccount = { server = "AccountServer", action = "account@accountLogin", fields = "username,password" }

Action.LoginRegister = { server = "AccountServer", action = "account@accountRegister", fields = "username,password" }

Action.LoginGameServer = { server = "GameServer", action = "player@login", fields = "aid,token"}

Action.EnterGame = { server = "GameServer", action = "role@enterGame", fields = "playerId" }

Action.FetchRandomName = { server = "GameServer", action = "role@randomName", fields = "playerId"}

Action.CreateRole = { server = "GameServer", action = "role@roleCreate", fields = "playerId,roleName"}

---==================
--- Role
---==================

--获取角色资源
Action.GetResource = { server = "GameServer", action = "role@getResource", fields = "roleId" }
---==================
--- Card
---==================
--获取当前角色所拥有卡牌信息
Action.CardList = { server = "GameServer", action = "Card@cardList", fields = "roleId" }

--卡池信息
Action.CardPoolInfo = { server = "GameServer", action = "Card@cardPoolInfo", fields = "" }

--抽卡
Action.DrawCard = { server = "GameServer", action = "Card@drawCard", fields = "roleId,cardPoolName,drawCardType,drawCardNum" }


---==================
--- Item
---==================
--获取当前角色所拥物品信息
Action.ItemList = { server = "GameServer", action = "Item@itemList", fields = "roleId" }


---==================
--- Checkpoint
---==================
--获取章节信息
Action.ChapterInfo = { server = "GameServer", action = "checkpoint@chapterInfo", fields = "roleId,chapterId" }


---==================
--- Battle
---==================
--请求开始战斗
Action.StartBattle = {server = "GameServer", action = "battlereport@startBattle", fields = "roleId,chapterId,checkpointId,battleType,battleArray"}

--请求结束战斗
Action.EndBattle = {server = "GameServer", action = "battlereport@endBattle", fields = "roleId,chapterId,checkpointId"}

--请求生成战报
Action.GenerateBattleReport = { server = "GameServer", action = "battlereport@generateBattleReport", fields = "roleId,checkpointId" }

--获取战斗配置
Action.GetBattleConfig = { server = "GameServer", action = "battleConfig@getBattleConfig", fields = "roleId,battleType" }

--保存编组
Action.SaveBattleArray = { server = "GameServer", action = "battleConfig@saveBattleArray", fields = "roleId,battleType,battleArray" }

--保存速度和自动
Action.SaveBattleConfig = { server = "GameServer", action = "battleConfig@saveBattleConfig", fields = "roleId,battleType,battleSpeed,battleAuto" }

return Action