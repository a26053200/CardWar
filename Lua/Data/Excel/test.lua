local Data = {
    [1] = {field1 = 1, field2 = "a1", field3 = 1, field4 = "asd1"},
    [2] = {field1 = 2, field2 = "a2", field3 = 2, field4 = "asd2"},
    [3] = {field1 = 3, field2 = "a3", field3 = 3, field4 = "asd3"},
    [4] = {field1 = 4, field2 = "a4", field3 = 4, field4 = ""},
    [5] = {field1 = 5, field2 = "a5", field3 = 0, field4 = ""},
    [6] = {field1 = 6, field2 = "a6", field3 = 0, field4 = ""},
    [7] = {field1 = 7, field2 = "a7", field3 = 0, field4 = ""},
    [8] = {field1 = 8, field2 = "a8", field3 = 0, field4 = ""},
    [9] = {field1 = 9, field2 = "a9", field3 = 0, field4 = ""},
    [10] = {field1 = 10, field2 = "a10", field3 = 10, field4 = "asd10"},
    [11] = {field1 = 11, field2 = "a11", field3 = 11, field4 = "asd11"},
    [12] = {field1 = 12, field2 = "a12", field3 = 12, field4 = "asd12"},
    [13] = {field1 = 13, field2 = "a13", field3 = 13, field4 = "asd13"},
}

function Data.Get(id)
    if Data[id] == nil then
        logError(string.Format('There is no id = %s data is table <test.xlsx>', id))
        return nil
    else
        return Data[id]
    end
end

return Data
                
