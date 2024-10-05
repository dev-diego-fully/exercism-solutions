local grains = {}

local function subtotal(n, prev_grains)
    if n == 1 then
        return prev_grains;
    else
        return subtotal(n - 1, prev_grains + grains.square(n))
    end
end

function grains.square(n)
    return 2 ^ (n - 1)
end

function grains.total()
    return subtotal(64, 0)
end

return grains
