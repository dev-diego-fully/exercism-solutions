--- A module that translates a secret code into a sequence of handshake actions.

--- A constant table that maps bit values to their corresponding handshake actions.
--- The bit values are powers of 2 (1, 2, 4, 8).
local COMMON_ACTIONS <const> = {
    { 1, "wink" },
    { 2, "double blink" },
    { 4, "close your eyes" },
    { 8, "jump" }
}
--- The bit value that, when present, reverses the order of the actions.
local REVERSE_ACTION <const> = 16

local handshake, reverse

--- Translates an integer secret code into a sequence of handshake actions.
--- The actions are determined by the bit values present in the integer.
--- @param n integer The integer secret code.
--- @return string[] A table of strings representing the handshake actions.
function handshake(n)
    local actions = {}

    for _, action in ipairs(COMMON_ACTIONS) do
        if action[1] & n ~= 0 then
            table.insert(actions, action[2])
        end
    end

    if n & REVERSE_ACTION ~= 0 then
        reverse(actions)
    end

    return actions
end

--- Reverses the order of elements in a table in place.
--- This is an internal helper function.
--- @generic T
--- @param list T[] The table to be reversed.
function reverse(list)
    local i = 1
    local j = #list

    while i < j do
        list[i], list[j] = list[j], list[i]
        i, j = i + 1, j - 1
    end
end

--- @return fun(n: integer): string[] The public handshake function.
return handshake