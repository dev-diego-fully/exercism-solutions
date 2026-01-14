local is_divisible, leap_year

--- Returns whether the first argument is divisible by the second.
--- @param dividend integer
--- @param divisor integer
--- @return boolean
function is_divisible(dividend, divisor)
    return dividend % divisor == 0
end

--- Returns whether the given year is a leap year or not.
--- @param year integer
--- @return boolean
function leap_year(year)
    return (
        is_divisible(year, 4) and
        not is_divisible(year, 100) or
        is_divisible(year, 400)
    )
end

return leap_year
