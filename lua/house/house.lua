--- A module for generating the nursery rhyme "This Is the House That Jack Built".
local house = {}

local that_do, this_is

--- A constant table containing the rhyming pairs for the song.
--- Each pair consists of an action and a subject.
local PAIRS <const> = {
    { "lay in",      "house that Jack built" },
    { "ate",         "malt" },
    { "killed",      "rat" },
    { "worried",     "cat" },
    { "tossed",      "dog" },
    { "milked",      "cow with the crumpled horn" },
    { "kissed",      "maiden all forlorn" },
    { "married",     "man all tattered and torn" },
    { "woke",        "priest all shaven and shorn" },
    { "kept",        "rooster that crowed in the morn" },
    { "belonged to", "farmer sowing his corn" },
    { "",            "horse and the hound and the horn" }
}

--- Generates a specific verse of the rhyme.
--- @param which integer The index of the verse to generate.
--- @return string -- The formatted verse.
house.verse = function(which)
    local lines = {}

    table.insert(lines, this_is(PAIRS[which][2], which == 1))

    for i = which - 1, 1, -1 do
        table.insert(lines, that_do(PAIRS[i][1], PAIRS[i][2], i == 1))
    end

    return table.concat(lines, "\n")
end

--- Generates the complete nursery rhyme, from start to finish.
--- @return string -- The full, formatted rhyme.
house.recite = function()
    local verses = {}

    for i = 1, #PAIRS, 1 do
        table.insert(verses, house.verse(i))
    end

    return table.concat(verses, "\n")
end

--- A constant format string for the lines of the form "that [action] the [subject]".
local THAT_LINE_FORMAT <const> = "that %s the %s%s"
--- A constant format string for the opening line of a verse: "This is the [thing]".
local THIS_LINE_FORMAT <const> = "This is the %s%s"

--- Formats a single line of the form "that [action] the [subject]".
--- @param action string The action verb.
--- @param subject string The subject of the line.
--- @param terminal boolean True if the line should end with a period.
--- @return string -- The formatted line.
function that_do(action, subject, terminal)
    local terminator = terminal and "." or ""

    return THAT_LINE_FORMAT:format(action, subject, terminator)
end

--- Formats the opening line of a verse.
--- @param thing string The item being introduced.
--- @param terminal boolean True if the line should end with a period.
--- @return string -- The formatted line.
function this_is(thing, terminal)
    local terminator = terminal and "." or ""

    return THIS_LINE_FORMAT:format(thing, terminator)
end

return house
