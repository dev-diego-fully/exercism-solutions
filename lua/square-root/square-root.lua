local SquareRoot = {}

local number = {}

function number.is_integer(x)
    return math.floor(x) == x
end

function number.is_positive(x)
    return x > 0
end

local function search(first, last, distance_meter)
    if first == last then
        if distance_meter(first) == 0 then
            return first
        else
            return error("Not found")
        end
    end
    local pivot = first + (last - first) / 2
    local distance = distance_meter(pivot)

    if distance == 0 then
        return pivot
    elseif distance > 0 then
        return search(first, pivot, distance_meter)
    else
        return search(pivot, last, distance_meter)
    end
end

function SquareRoot.square_root(radicand)
    if not number.is_positive(radicand) or
        not number.is_integer(radicand) then
        error("Try to compute a non natural number")
    end
    local distance_meter = function(x)
        return x ^ 2 - radicand
    end
    return search(0, radicand, distance_meter)
end

return SquareRoot
