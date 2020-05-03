-- Avatar Last Edit By:zheng
local Data = {}
Data.table = {    ["Villager_B_Boy"] = {id = "Villager_B_Boy", name = "Villager", type = "", hudOffset = "0,110,0", scale = 1.2, animBorn = "DrawDagger", animIdle = "Attackstandy", animDead = "Death", animRun = "Run", animWin = "Elevator", animHit = "Damage", prefabUrl = "Models/villarger_B_Boy/Prefabs/Villager_B_Boy.prefab"},
    ["micro_dragon"] = {id = "micro_dragon", name = "Micro Dragon", type = "", hudOffset = "0,110,0", scale = 0.6, animBorn = "dragon_land_on_ground", animIdle = "dragon_idle", animDead = "dragon_die", animRun = "dragon_take_off", animWin = "dragon_laugh", animHit = "dragon_hit_front", prefabUrl = "Models/Dragon/Prefabs/micro_dragon.prefab"},
    ["Ghost"] = {id = "Ghost", name = "Ghost", type = "", hudOffset = "0,110,0", scale = 0.6, animBorn = "ghost_rise_from_floor", animIdle = "ghost_idle_hover", animDead = "ghost_sleeping", animRun = "ghost_idle_back_and_forth", animWin = "ghost_laugh", animHit = "ghost_hit_front", prefabUrl = "Models/Ghost/Prefabs/micro_ghost.prefab"},
    ["Werewolf"] = {id = "Werewolf", name = "Werewolf", type = "", hudOffset = "0,110,0", scale = 0.6, animBorn = "wolf_getup", animIdle = "wolf_idle1", animDead = "wolf_die", animRun = "wolf_walk", animWin = "wolf_laugh", animHit = "wolf_hit_front", prefabUrl = "Models/Werewolf/Prefabs/micro_werewolf.prefab"},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <Avatar.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
