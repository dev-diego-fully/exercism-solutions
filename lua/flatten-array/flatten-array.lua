--- Recursively flattens a table, converting all nested tables into a single-level table.
--- This function iterates through the input table. For each element, it checks if the element
--- is a table; if so, it recursively calls itself to flatten the nested table.
--- Non-table elements are inserted directly into the result.
--- @param input table The table to be flattened.
--- @return table -- A new table with all elements from the input and its nested tables.
local function flatten(input)
    local result = {}
    
    for _, a in ipairs(input) do
        if type(a) == "table" then
            for _, b in ipairs(flatten(a)) do
                table.insert(result, b)
            end
        else
            table.insert(result, a)
        end
    end
    
    return result
end

return flatten