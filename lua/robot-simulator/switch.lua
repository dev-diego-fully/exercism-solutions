--- Replicates the default behavior of a switch in other programming
--- languages. Checks whether value is equal to any of the elements of
--- the cases array (in order), if so, returns the value of results that
--- is at the same index as the first positive case found. If no match is
--- found, returns the default value.
--- @generic T, U
--- @param cases T[]
--- @param results U[]
--- @param value T
--- @param default U
--- @return U
local function switch(cases, results, value, default)
    for index, case in ipairs(cases) do
        if value == case then
            return results[index]
        end
    end
    return default
end

--- Returns a closure that simulates the effect of a "static" or
--- reusable switch. Receives an array of cases, an array of results, and
--- optionally a default value. Returns a function that, given a value,
--- searches for the first matching case. If a match is found, the
--- corresponding result (same index) is returned. If no match is found,
--- the default value is returned.
---@generic T, U
---@param cases T[]
---@param results U[]
---@param default? U
---@return fun(value:T):U
local function switcher(cases, results, default)
    return function(value)
        return switch(cases, results, value, default)
    end
end


return switcher
