--- A module that generates the "Green Bottles" song.
local BottleSong = {}

local verse, capitalize, terminator_for

--- Recites a specified number of verses of the "Green Bottles" song.
--- @param start_bottles integer The starting number of bottles.
--- @param take_down integer The number of verses to generate.
--- @return string The generated verses, separated by newlines.
function BottleSong.recite(start_bottles, take_down)
    local verses = {}
    local haging_on_last_verse = start_bottles - take_down + 1

    for hanging = start_bottles, haging_on_last_verse, -1 do
        verses[#verses + 1] = verse(hanging)
    end

    return table.concat(verses, "\n")
end

--- The format string for a single verse of the song.
local VERSE_FORMAT <const> = [[
%s green bottle%s hanging on the wall,
%s green bottle%s hanging on the wall,
And if one green bottle should accidentally fall,
There'll be %s green bottle%s hanging on the wall.
]];

--- A constant table mapping bottle counts to their string representations.
local SAID_COUNTS <const> = {
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    [0] = "no"
}

--- Generates a single verse of the song based on the number of bottles hanging.
--- @param hanging_count integer The number of bottles for this verse.
--- @return string The formatted verse.
function verse(hanging_count)
    local initial_count_said = capitalize(SAID_COUNTS[hanging_count])
    local initial_terminator = terminator_for(hanging_count)
    local next_count = SAID_COUNTS[hanging_count - 1]
    local next_terminator = terminator_for(hanging_count - 1)

    return VERSE_FORMAT:format(
        initial_count_said, initial_terminator,
        initial_count_said, initial_terminator,
        next_count, next_terminator
    )
end

--- Capitalizes the first letter of a string.
--- @param str string The string to capitalize.
--- @return string The capitalized string.
function capitalize(str)
    return str:sub(1, 1):upper() .. str:sub(2)
end

--- Returns the plural terminator "s" for a count, or an empty string for a singular count.
--- @param count integer The bottle count.
--- @return string The plural terminator ("s") or an empty string.
function terminator_for(count)
    if count == 1 then
        return ""
    else
        return "s"
    end
end

return BottleSong