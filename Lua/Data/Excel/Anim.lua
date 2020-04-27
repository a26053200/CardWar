-- Anim 2020/4/28 0:50:27
local Data = {}
Data.table = {    ["Villager_B_Boy_atk"] = {id = "Villager_B_Boy_atk", animName = "Combo", animSpeed = 1, accountPoint = 0.5, animEffect = ""},
    ["Villager_B_Boy_skill"] = {id = "Villager_B_Boy_skill", animName = "Skill", animSpeed = 1, accountPoint = 0.5, animEffect = ""},
    ["micro_dragon_atk"] = {id = "micro_dragon_atk", animName = "dragon_bite", animSpeed = 1, accountPoint = 0.5, animEffect = ""},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", animName = "dragon_attack_repeatedly", animSpeed = 1, accountPoint = 0.5, animEffect = ""},
    ["Ghost_atk"] = {id = "Ghost_atk", animName = "ghost_attack_with_ball", animSpeed = 1, accountPoint = 0.5, animEffect = ""},
    ["Ghost_skill"] = {id = "Ghost_skill", animName = "ghost_spin_attack", animSpeed = 1, accountPoint = 0.5, animEffect = ""},
    ["Werewolf_atk"] = {id = "Werewolf_atk", animName = "wolf_bite", animSpeed = 1, accountPoint = 0.5, animEffect = ""},
    ["Werewolf_skill"] = {id = "Werewolf_skill", animName = "wolf_attack_repeatedly", animSpeed = 1, accountPoint = 0.5, animEffect = ""},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <Anim.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
