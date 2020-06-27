-- BattleUnit Last Edit By:zheng
local Data = {}
Data.table = 
{
    ["Micro_Dragon"] = {id = "Micro_Dragon", name = "Micro Dragon", avatarName = "micro_dragon", type = "Monster", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["Ghost"] = {id = "Ghost", name = "Ghost", avatarName = "Ghost", type = "Monster", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["Werewolf"] = {id = "Werewolf", name = "Werewolf", avatarName = "Werewolf", type = "Monster", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero1"] = {id = "hero1", name = "英雄1", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero2"] = {id = "hero2", name = "英雄2", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero3"] = {id = "hero3", name = "英雄3", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero4"] = {id = "hero4", name = "英雄4", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero5"] = {id = "hero5", name = "英雄5", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero6"] = {id = "hero6", name = "英雄6", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero7"] = {id = "hero7", name = "英雄7", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero8"] = {id = "hero8", name = "英雄8", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero9"] = {id = "hero9", name = "英雄9", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero10"] = {id = "hero10", name = "英雄10", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero11"] = {id = "hero11", name = "英雄11", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero12"] = {id = "hero12", name = "英雄12", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero13"] = {id = "hero13", name = "英雄13", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero14"] = {id = "hero14", name = "英雄14", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero15"] = {id = "hero15", name = "英雄15", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero16"] = {id = "hero16", name = "英雄16", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero17"] = {id = "hero17", name = "英雄17", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero18"] = {id = "hero18", name = "英雄18", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero19"] = {id = "hero19", name = "英雄19", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero20"] = {id = "hero20", name = "英雄20", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero21"] = {id = "hero21", name = "英雄21", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero22"] = {id = "hero22", name = "英雄22", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero23"] = {id = "hero23", name = "英雄23", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero24"] = {id = "hero24", name = "英雄24", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero25"] = {id = "hero25", name = "英雄25", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero26"] = {id = "hero26", name = "英雄26", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero27"] = {id = "hero27", name = "英雄27", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero28"] = {id = "hero28", name = "英雄28", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero29"] = {id = "hero29", name = "英雄29", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero30"] = {id = "hero30", name = "英雄30", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero31"] = {id = "hero31", name = "英雄31", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero32"] = {id = "hero32", name = "英雄32", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero33"] = {id = "hero33", name = "英雄33", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero34"] = {id = "hero34", name = "英雄34", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero35"] = {id = "hero35", name = "英雄35", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero36"] = {id = "hero36", name = "英雄36", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero37"] = {id = "hero37", name = "英雄37", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero38"] = {id = "hero38", name = "英雄38", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero39"] = {id = "hero39", name = "英雄39", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero40"] = {id = "hero40", name = "英雄40", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero41"] = {id = "hero41", name = "英雄41", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero42"] = {id = "hero42", name = "英雄42", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero43"] = {id = "hero43", name = "英雄43", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero44"] = {id = "hero44", name = "英雄44", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
    ["hero45"] = {id = "hero45", name = "英雄45", avatarName = "Villager_B_Boy", type = "Hero", cost = 10, atk = 100, def = 10, crit = 0.3, critPow = 1.5, maxHp = 1000, maxAnger = 100, speed = 60},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <BattleUnit.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
