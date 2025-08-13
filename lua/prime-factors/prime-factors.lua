--- A local helper function that checks if 'x' is evenly divisible by 'y'.
--- @param x integer The number to be divided.
--- @param y integer The divisor.
--- @return boolean True if 'x' is divisible by 'y', false otherwise.
local function is_divisible(x, y)
    return x % y == 0
end

--- A recursive helper function to find the prime factors of a number.
--- It progressively divides the number by the smallest possible factor until the number is fully factorized.
--- @param num integer The number currently being factorized.
--- @param current_factor integer The current factor to test for divisibility.
--- @param factors integer[] A table of prime factors found so far.
--- @return integer[] A table containing all the prime factors.
local function do_factorate(num, current_factor, factors)
    if num < current_factor then
        return factors
    end
    if is_divisible(num, current_factor) then
        table.insert(factors, current_factor)
        return do_factorate(num / current_factor, current_factor, factors)
    end
    if not is_divisible(current_factor, 2) then
        return do_factorate(num, current_factor + 2, factors)
    end
    return do_factorate(num, current_factor + 1, factors)
end

--- Calculates the prime factors of a number.
--- @param input integer The number to be factorized.
--- @return integer[] A table containing the prime factors of the input number.
return function(input)
    return do_factorate(input, 2, {})
end