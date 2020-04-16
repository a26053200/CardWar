-- Anim 2020/4/17 0:04:07
local Data = {
    ["micro_dragon_atk"] = {id = "micro_dragon_atk", animName = "dragon_bite", animSpeed = 1, accountPoint = 0, animEffect = ""},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", animName = "dragon_attack_repeatedly", animSpeed = 1, accountPoint = 0, animEffect = ""},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.format('There is no id = %s data is table <Anim.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
