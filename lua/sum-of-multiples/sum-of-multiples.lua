local function is_divisible(number, divisor)
    if divisor ~= 0 then
        return number % divisor == 0
    elseif number == 0 then
        return true
    else
        return false
    end 
end

local function has_divisor_in_set(number, divisors)
    for _, v in ipairs(divisors) do
        if is_divisible(number, v) then
            return true
        end
    end
    return false
end

local function sum_of_multiples(divisors, limit)
    local sum = 0
    for i = 1, limit - 1, 1 do
        if has_divisor_in_set(i, divisors) then
            sum = sum + i
        end
    end
    return sum
end

return function(numbers)
    local divisors = {table.unpack(numbers)}
    return {
        to = function(limit)
            return sum_of_multiples(divisors, limit)
        end
    } 
end
