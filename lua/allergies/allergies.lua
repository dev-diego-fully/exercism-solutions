--- A module for checking and listing allergies based on a numerical score (bitmask).
local allergies <const> = {}

--- An enumeration of possible allergies, with each allergy assigned a unique bit value.
--- Each value is a power of two, allowing multiple allergies to be stored in a single integer using bitwise operations.
--- @enum Allergy
local Allergy <const> = {
    eggs = { "eggs", 1 },
    peanuts = { "peanuts", 2 },
    shellfish = { "shellfish", 4 },
    strawberries = { "strawberries", 8 },
    tomatoes = { "tomatoes", 16 },
    chocolate = { "chocolate", 32 },
    pollen = { "pollen", 64 },
    cats = { "cats", 128 }
}

--- A constant table containing the names of all defined allergies in a specific order.
--- This list is used to ensure the `list` function returns results in a consistent, predictable order.
local ordereds_allergies <const> = {
    Allergy.eggs[1], Allergy.peanuts[1], Allergy.shellfish[1],
    Allergy.strawberries[1], Allergy.tomatoes[1], Allergy.chocolate[1],
    Allergy.pollen[1], Allergy.cats[1]
}

--- Returns a list of all allergies corresponding to a given score.
--- The function iterates through all known allergies and checks if each one is present in the score.
--- @param score integer The bitmask representing the user's allergies.
--- @return string[] -- A table of strings, where each string is an allergy name.
function allergies.list(score)
    local result = {}

    for _, item in ipairs(ordereds_allergies) do
        if allergies.allergic_to(score, item) then
            table.insert(result, item)
        end
    end

    return result
end

--- Checks if a specific allergy is present in the given score.
--- This check is performed using a bitwise AND operation. A non-zero result indicates that the bit for the specific allergy is set in the score.
--- @param score integer The bitmask representing the user's allergies.
--- @param which string The name of the allergy to check.
--- @return boolean -- True if the allergy is present in the score, false otherwise.
function allergies.allergic_to(score, which)
    return score & Allergy[which][2] ~= 0
end

return allergies