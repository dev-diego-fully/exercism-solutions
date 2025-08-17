--- A module for validating numbers (such as credit card numbers) using the Luhn algorithm.
local luhn <const> = {}

local has_luhn_format, digits_of_luhn, luhn_sum, luhn_double

--- Validates a number string according to the Luhn algorithm.
--- The function checks if the string contains only digits and spaces, has at least two digits,
--- and if the Luhn sum is a multiple of 10.
--- @param str string The number string to validate.
--- @return boolean -- `true` if the number is valid, `false` otherwise.
function luhn.valid(str)
  if not has_luhn_format(str) then
    return false
  end

  local digits <const> = digits_of_luhn(str)

  if #digits <= 1 then
    return false
  end

  return luhn_sum(digits) % 10 == 0
end

--- Checks if a string contains only digits and spaces.
--- @param str string The string to check.
--- @return boolean -- `true` if the string has a valid format, `false` otherwise.
function has_luhn_format(str)
  return str:match("[^%d%s]") == nil
end

--- Extracts all digit characters from a string and converts them into a table of numbers.
--- @param str string The string to process.
--- @return integer[] -- A table containing the digits as numbers.
function digits_of_luhn(str)
  local digs = {}

  for digit in str:gmatch("%d") do
    table.insert(digs, tonumber(digit))
  end

  return digs
end

--- Calculates the Luhn sum of a table of digits.
--- This sum is calculated by iterating through the digits from right to left, doubling
--- every second digit, and then adding all the digits together.
--- @param digits integer[] The table of digits.
--- @return integer -- The calculated Luhn sum.
function luhn_sum(digits)
  local digits_count <const> = #digits
  local sum = 0

  for i = 1, digits_count, 1 do
    local index <const> = digits_count - i + 1
    local digit <const> = digits[index]
    if i % 2 == 0 then
      sum = sum + luhn_double(digit)
    else
      sum = sum + digit
    end
  end

  return sum
end

--- Doubles a digit as part of the Luhn algorithm.
--- If the doubled value is greater than 9, it is replaced by the sum of its digits
--- (e.g., 14 becomes 1 + 4 = 5).
--- This is equivalent to subtracting 9.
--- @param digit integer The digit to double.
--- @return integer -- The doubled digit, adjusted if greater than 9.
function luhn_double(digit)
  local result <const> = 2 * digit

  if result > 9 then
    return result - 9
  end
  return result
end

return luhn
