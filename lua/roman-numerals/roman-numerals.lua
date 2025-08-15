--- A module for converting integers to Roman numerals.
local roman <const> = {}

--- A constant lookup table containing Roman numeral symbols and their integer values.
--- The table is ordered from smallest to largest value, which is crucial for the conversion algorithm.
local ROMAN_RUNES <const> = {
  { 1,  "I" }, { 4, "IV" }, { 5, "V" }, { 9, "IX" },
  { 10, "X" }, { 40, "XL" }, { 50, "L" }, { 90, "XC" },
  { 100,  "C" }, { 400, "CD" }, { 500, "D" }, { 900, "CM" },
  { 1000, "M" }
}

--- Converts an integer to its Roman numeral representation.
--- The algorithm iterates through the Roman numeral values from largest to smallest,
--- subtracting the largest possible value from the number and collecting the corresponding symbol in a table.
--- Finally, the symbols are concatenated to form the result string.
--- @param n integer The integer to convert.
--- @return string -- The Roman numeral representation of the number.
function roman.to_roman(n)
  local current = n
  local result = {}

  for i = #ROMAN_RUNES, 1, -1 do
    local value = ROMAN_RUNES[i][1]
    local rune = ROMAN_RUNES[i][2]
    
    while current >= value do
      current = current - value
      table.insert(result, rune)
    end
  end

  return table.concat(result)
end

return roman