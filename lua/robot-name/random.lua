--- A module for generating random characters and integers.
local random <const> = {}

--- The ASCII byte value of the character before "A".
local UPPER_START <const> = string.byte("A") - 1
--- The number of letters in the English alphabet.
local ALPHABET_LEN <const> = 26

--- Generates a random integer within a specified range (inclusive).
--- This is a wrapper around Lua's `math.random`.
--- @param bot integer The lower bound of the range.
--- @param top integer The upper bound of the range.
--- @return integer -- The generated random integer.
function random.integer(bot, top)
    return math.random(bot, top)
end

--- Generates a single random uppercase letter from "A" to "Z".
--- @return string -- The generated random uppercase letter.
function random.upper_case()
    local index = math.random(1, ALPHABET_LEN)
    return string.char(UPPER_START + index)
end

return random