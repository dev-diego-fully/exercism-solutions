--- A module for converting numbers between different bases.
local all_your_base <const> = {}

--- Converts a list of digits from a given base to a single decimal value.
--- This function validates the input base and all digits. It will throw an error if:
--- - The `base` is less than 2.
--- - A `digit` is negative.
--- - A `digit` is greater than or equal to the `base`.
--- @param digits integer[] A table of digits to be converted.
--- @param base integer The base of the input digits.
--- @return integer -- The decimal value of the number.
local function to_value(digits, base)
    assert(base >= 2, "invalid input base")

    local digits_count <const> = #digits
    local value = 0

    for i = digits_count, 1, -1 do
        local digit <const> = digits[i]

        assert(digit >= 0, "negative digits are not allowed")
        assert(digit < base, "digit out of range")

        value = value + digit * base ^ (digits_count - i)
    end

    return value
end

--- Converts a decimal value to a list of digits in a new base.
--- This function validates the output base. It will throw an error if the `base` is less than 2.
--- @param value integer The decimal value to convert.
--- @param base integer The base to convert to.
--- @return integer[] -- A table of digits representing the number in the new base.
local function from_value(value, base)
    assert(base >= 2, "invalid output base")

    if value == 0 then
        return { 0 }
    end

    local digits <const> = {}
    local current = value

    while current > 0 do
        table.insert(digits, 1, current % base)
        current = math.floor(current / base)
    end

    return digits
end

--- Initializes the base conversion process.
--- This function takes the number to be converted in its initial base and returns a table with a `to` method to complete the conversion.
--- @param input_digits integer[] A table of digits to be converted.
--- @param input_base integer The base of the input digits.
--- @return {to: fun(base: integer): integer} -- A table containing the final conversion method.
function all_your_base.convert(input_digits, input_base)
    local value = to_value(input_digits, input_base)

    return {
        --- The final conversion method.
        --- This function converts the number to the final desired base.
        --- It returns a copy of the input digits if the bases are the same.
        --- @param base integer The base to convert to.
        --- @return integer[] -- A table of digits representing the number in the new base.
        to = function(base)
            if input_base == base then
                return { table.unpack(input_digits) }
            end
            return from_value(value, base)
        end
    }
end

return all_your_base