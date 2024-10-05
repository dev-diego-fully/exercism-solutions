
local ArmstrongNumbers = {}


local digits = {}

function digits.get(str_number, nth)
    local digit = string.sub(str_number, nth, nth)
    return tonumber(digit)
end

function digits.map(str_number, callback)
    local mapped = {}
    for i = 1, #str_number, 1 do
        mapped[i] = callback(digits.get(str_number, i))
    end
    return mapped
end

local vector = {}

function vector.sum(vec)
    local sum = 0
    for _, v in ipairs(vec) do
        sum = sum + v
    end
    return sum
end

local function armstrong_digiter(num_size)
    return function(d)
        return d ^ num_size
    end
end

function ArmstrongNumbers.is_armstrong_number(number)
    local str_number = tostring(number)
    local digiter = armstrong_digiter(#str_number)
    local powereds_digits = digits.map(str_number, digiter)
    return vector.sum(powereds_digits) == number
end

return ArmstrongNumbers
