---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zheng.
--- DateTime: 2020/7/5 1:40
--- 战报系统的常量
---

--对阵阵营
---@class Camp
Camp = {
    Atk = "Atk",    --攻防阵营
    Def = "Def",    --守方阵营
}


---@class TargetMode
TargetMode =
{
    Self = "Self",      --施法者本身
    Friend = "Friend",  --友方个体，包括自己
    Enemy = "Enemy",    --敌方
    AOE = "AOE",        --具体位置（形状）
    Pos = "Pos",        --具体位置（形状）
}

---@class AttackType
AttackType =
{
    Physic = "Physic",
    Magic = "Magic"
}

---@class GridSelectType
GridSelectType =
{
    Friend = "Friend",
    Friend_Lowest = "Friend_Lowest",
    Friend_All = "Friend_All",
    Current = "Current",
    Col = "Col",
    Row = "Row",
    All = "All",
}
LayoutIndex2Col =
{
    [1] = {1,4,9},
    [2] = {2,5,8},
    [3] = {3,6,7},
    [4] = {1,4,9},
    [5] = {2,5,8},
    [6] = {3,6,7},
    [7] = {1,4,9},
    [8] = {2,5,8},
    [9] = {3,6,7},
}

LayoutIndex2Row =
{
    [1] = {1,2,3},
    [2] = {1,2,3},
    [3] = {1,2,3},
    [4] = {4,5,6},
    [5] = {4,5,6},
    [6] = {4,5,6},
    [7] = {7,8,9},
    [8] = {7,8,9},
    [9] = {7,8,9},
}

LayoutMapAll = {1,2,3,4,5,6,7,8,9}