-- Performance 2020/4/17 0:04:07
local Data = {
    ["micro_dragon_atk"] = {id = "micro_dragon_atk", name = "普通攻击", type = "", accountAction = "micro_dragon_atk", duration = 0, interval = 0, delay = 0, param = "", accountAction = "", shake = ""},
    ["micro_dragon_skill"] = {id = "micro_dragon_skill", name = "技能", type = "", accountAction = "micro_dragon_skill", duration = 0, interval = 0, delay = 0, param = "", accountAction = "", shake = ""},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.format('There is no id = %s data is table <Performance.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
