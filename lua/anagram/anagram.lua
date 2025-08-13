--- Represents a word and can find its anagrams in a list of candidates.
--- @class Anagram
local Anagram <const> = {}

--- The internal representation of an Anagram object.
--- This class holds the processed string data for efficient comparisons.
--- @class PrivAnagram : Anagram
--- @field _lowered string The original string converted to lowercase.
--- @field _normalized string The lowercase string with its characters sorted alphabetically.
local PrivAnagram <const> = {}

local str_chars, str_sort

Anagram.__index = Anagram

--- Creates a new Anagram instance.
--- The string is pre-processed into a lowercase version and a normalized (sorted) version
--- for quick comparisons.
--- @param str string The original string.
--- @return Anagram -- The new Anagram instance.
function Anagram:new(str)
    local lowered = str:lower()

    local anagram = {
        _lowered = lowered,
        _normalized = str_sort(lowered)
    }
    return setmetatable(anagram, Anagram)
end

--- Finds all anagrams of the original word within a list of candidates.
--- @param self Anagram
--- @param candidates string[] A table of candidate strings to check.
--- @return string[] -- A table containing all the valid anagrams found.
function Anagram.match(self, candidates)
    local anagrams = {}

    for _, candidate in ipairs(candidates) do
        if self:is_anagram(candidate) then
            table.insert(anagrams, candidate)
        end
    end

    return anagrams
end

--- Checks if a candidate string is an anagram of the original word.
--- A word cannot be an anagram of itself.
--- @param self Anagram
--- @param candidate string The candidate string to check.
--- @return boolean -- True if the candidate is an anagram, false otherwise.
function Anagram.is_anagram(self, candidate)
    ---@cast self PrivAnagram
    local lowered = candidate:lower()

    if lowered == self._lowered then
        return false
    end
    return str_sort(lowered) == self._normalized
end

--- Sorts the characters of a string alphabetically.
--- @param str string The string to sort.
--- @return string -- The string with its characters sorted.
function str_sort(str)
    local chars = str_chars(str)
    table.sort(chars)
    return table.concat(chars, "")
end

--- Breaks a string into a table of single-character strings.
--- @param str string The string to break up.
--- @return string[] -- A table of single-character strings.
function str_chars(str)
    local chars = {}

    for char in str:gmatch(".") do
        table.insert(chars, char)
    end

    return chars
end

return Anagram