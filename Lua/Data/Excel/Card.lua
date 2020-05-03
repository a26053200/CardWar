-- Card Last Edit By:zheng
local Data = {}
Data.table = {    [100001] = {id = 100001, name = "村民", type = "", battleUnit = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
    [100002] = {id = 100002, name = "村民", type = "", battleUnit = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
    [100003] = {id = 100003, name = "村民", type = "", battleUnit = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
    [100004] = {id = 100004, name = "村民", type = "", battleUnit = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
    [100005] = {id = 100005, name = "村民", type = "", battleUnit = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
    [100006] = {id = 100006, name = "村民", type = "", battleUnit = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
    [100007] = {id = 100007, name = "村民", type = "", battleUnit = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
    [100008] = {id = 100008, name = "村民", type = "", battleUnit = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
    [100009] = {id = 100009, name = "村民", type = "", battleUnit = "Villager_B_Boy", star = 1, level = 1, rarity = 1, rarityLabel = "SR"},
}

function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <Card.xlsx>', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                
