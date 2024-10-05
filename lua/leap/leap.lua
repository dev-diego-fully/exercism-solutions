local function divisible(dividend, divisor)
    return dividend % divisor == 0
end

local leap_year = function(year)
    return (
        divisible(year, 4) and
        not divisible(year, 100) or
        divisible(year, 400)
    )
end

return leap_year
