-- Card 2020/4/17 0:04:07
local Data = {
    [100001] = {id = 100001, name = "村民", type = "", avatarName = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.format('There is no id = %s data is table <Card.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
