-- Skill 2020/4/17 0:04:07
local Data = {
    ["micro_dragon_atk"] = {id = "micro_dragon_atk", owner = "micro_dragon", name = "普通攻击", type = "Normal", performance = "micro_dragon_atk"},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", owner = "micro_dragon", name = "技能", type = "Skill", performance = "micro_dragon_skill"},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.format('There is no id = %s data is table <Skill.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
