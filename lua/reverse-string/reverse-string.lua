---Reverses the given string.
---@param s string
---@return string
return function(s)
    local result = {}

    for c in s:gmatch(".") do
        table.insert(result, 1, c)
    end

    return table.concat(result, "")
end
