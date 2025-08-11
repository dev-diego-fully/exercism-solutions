--- A module for validating ISBN-10 codes.
local isbn <const> = {}

local normalize, has_isbn_format, has_valid_check_value
local has_correct_len, has_correct_placed_digits, has_only_isbn_digits, digits
local tern

--- The expected length of a normalized ISBN-10 string.
local ISBN_LEN <const> = 10
--- The modulo value used for the ISBN-10 checksum calculation.
local ISBN_CHECK_MODULO <const> = 11

--- Validates a potential ISBN-10 string.
--- It checks for the correct format and a valid checksum.
--- @param candidate string The string to validate.
--- @return boolean True if the string is a valid ISBN-10, false otherwise.
function isbn.valid(candidate)
  local normalized = normalize(candidate)
  return has_isbn_format(normalized) and has_valid_check_value(normalized)
end

--- Normalizes a string by removing whitespace, hyphens, and periods.
--- @param str string The string to normalize.
--- @return string The normalized string.
function normalize(str)
  local result, _ = str:gsub("[%s%-%.]", "")
  return result
end

--- Checks if a normalized string has the correct ISBN-10 format.
--- This includes correct length, valid characters, and correct check digit placement.
--- @param norm string The normalized string.
--- @return boolean True if the format is correct, false otherwise.
function has_isbn_format(norm)
  return has_correct_len(norm)
      and has_only_isbn_digits(norm)
      and has_correct_placed_digits(norm)
end

--- Extracts digits and the check digit 'X' from a string, converting them to numbers.
--- 'X' is converted to 10.
--- @param str_int string The string containing digits.
--- @return integer[] A table of the integer representations of the digits.
function digits(str_int)
  local result = {}

  for digit in str_int:gmatch("[%dX]") do
    table.insert(result, tern(digit == "X", 10, tonumber(digit)))
  end

  return result
end

--- Checks if a normalized string has the correct length for an ISBN-10.
--- @param norm string The normalized string.
--- @return boolean True if the length is 10, false otherwise.
function has_correct_len(norm)
  return norm:len() == ISBN_LEN
end

--- Checks if a normalized string contains only valid ISBN-10 characters (digits and 'X').
--- @param norm string The normalized string.
--- @return boolean True if all characters are valid, false otherwise.
function has_only_isbn_digits(norm)
  return norm:match("[^%dX]") == nil
end

--- Checks if the check digit 'X' is placed correctly (at the very end).
--- @param norm string The normalized string.
--- @return boolean True if 'X' is correctly placed or not present, false otherwise.
function has_correct_placed_digits(norm)
  return norm:match("X.") == nil
end

--- Validates the checksum of a normalized ISBN-10 string.
--- The sum of each digit multiplied by its position-based weight must be divisible by 11.
--- @param norm string The normalized string.
--- @return boolean True if the checksum is valid, false otherwise.
function has_valid_check_value(norm)
  local ndigits = digits(norm)
  local check_sum = 0

  for i = 1, ISBN_LEN, 1 do
    check_sum = check_sum + ndigits[i] * (ISBN_LEN + 1 - i)
  end

  return (check_sum % ISBN_CHECK_MODULO) == 0
end

--- A simple ternary operator function.
--- @generic T, U
--- @param cond boolean The condition to check.
--- @param true_case T The value to return if the condition is true.
--- @param false_case U The value to return if the condition is false.
--- @return T | U
function tern(cond, true_case, false_case)
  return cond and true_case or false_case
end

return isbn