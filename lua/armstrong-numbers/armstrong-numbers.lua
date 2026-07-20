local ArmstrongNumbers <const> = {}

local armstrong_sum, armstrong_digits_transformer;
local digits_of, vec_sum, vec_map;

--- Checks if a given integer is an Armstrong (narcissistic) number.
--- @param number integer The number to evaluate.
--- @return boolean # True if the number equals the sum of its digits raised to the power of the total digit count.
function ArmstrongNumbers.is_armstrong_number(number)
    local arm_sum <const> = armstrong_sum(number);

    return arm_sum == number;
end

--- Creates a transformation function that raises a digit to the power of the total digit count.
--- @param num_size integer The total number of digits.
--- @return fun(digit: integer): integer # A function that raises an input digit to the specified power.
function armstrong_digits_transformer(num_size)
    return function(d)
        return d ^ num_size;
    end
end

--- Calculates the Armstrong sum for a given integer.
--- @param num integer The integer to process.
--- @return integer # The sum of each digit raised to the power of the digit count.
function armstrong_sum(num)
    local digits <const> = digits_of(num);
    local arm_power = armstrong_digits_transformer(#digits);
    local arm_digits <const> = vec_map(digits, arm_power);

    return vec_sum(arm_digits);
end

--- Extracts the individual base-10 digits of an integer in order.
--- @param num integer The integer to decompose.
--- @return integer[] # An array containing the digits of the number.
function digits_of(num)
    local current_num = num;
    local digits <const> = {};

    while current_num > 0 do
        local digit = current_num % 10;

        table.insert(digits, 1, digit);

        current_num = math.floor(current_num / 10);
    end

    return digits;
end

--- Calculates the sum of all elements in a numeric array.
--- @param vec number[] The array of numbers to sum.
--- @return number # The total sum of the elements.
function vec_sum(vec)
    local sum = 0;
    for _, v in ipairs(vec) do
        sum = sum + v;
    end

    return sum;
end

--- Maps each element of an array using a transformation function.
--- @generic T, U
--- @param vec T[] The input array to transform.
--- @param op fun(elem: T): U The transformation function.
--- @return U[] # A new array containing the mapped values.
function vec_map(vec, op)
    local mapped <const> = {};

    for i, v in ipairs(vec) do
        mapped[i] = op(v);
    end

    return mapped;
end

return ArmstrongNumbers;
