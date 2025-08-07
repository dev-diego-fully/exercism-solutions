--- A module that generates a proverb from a list of strings.
local Proverb = {}

local for_a_want, all_for_want

--- Generates a complete proverb from a list of strings.
--- @param strings string[] A table of strings representing the items in the proverb.
--- @return string The formatted proverb as a single string.
function Proverb.recite(strings)
    local proverb = {}

    for i = 1, #strings - 1, 1 do
        proverb[i] = for_a_want(strings[i], strings[i + 1])
    end

    if #strings > 0 then
        proverb[#proverb + 1] = all_for_want(strings[1])
    end

    return table.concat(proverb, "")
end

--- Formats a single line of the proverb, indicating a loss due to a previous want.
--- @param wanted string The item that was wanted.
--- @param lost string The item that was lost.
--- @return string The formatted proverb line.
function for_a_want(wanted, lost)
    local line_format = "For want of a %s the %s was lost.\n"
    return line_format:format(wanted, lost)
end

--- Formats the final line of the proverb, which refers back to the first wanted item.
--- @param wanted string The first item that was wanted.
--- @return string The formatted final line of the proverb.
function all_for_want(wanted)
    local line_format = "And all for the want of a %s.\n"
    return line_format:format(wanted)
end

return Proverb