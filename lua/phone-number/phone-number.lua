--- A module that provides functionality to clean and validate phone number strings.
local phone_number = {}

local justDigits, validate

--- Cleans and validates a phone number string.
--- It removes non-digit characters and checks the number against a set of validation rules.
--- @param phone string The phone number string to process.
--- @return string -- The cleaned and validated 10-digit number
function phone_number.clean(phone)
    return validate(justDigits(phone))
end

--- Removes all non-digit characters from a string.
--- @param str string The string to clean.
--- @return string The string containing only digits.
function justDigits(str)
    local cleaned, _ = str:gsub("[^%d]", "")
    return cleaned
end

--- Validates a string of digits, checking for correct length, country code, and digit rules.
--- This function is internal and meant to be called with a string containing only digits.
--- @param num string A string of digits.
--- @return string -- The validated 10-digit number.
function validate(num)
    if #num <= 9 or #num >= 12 then
        error("phone numbers must contain 10 or 11 digits")
    end
    if #num == 11 and num:sub(1, 1) ~= "1" then
        error("country code must be 1")
    end
    local mainNumber = #num == 10 and num or num:sub(2)
    local firstDigit = tonumber(mainNumber:sub(1, 1))
    local fourthDigit = tonumber(mainNumber:sub(4, 4))

    if firstDigit < 2 or fourthDigit < 2 then
        error("the first and fourth digits of a number (disregarding the country code) cannot be 0 or 1")
    else
        return mainNumber
    end
end

return phone_number
