local function divisible(n, d)
    return n % d == 0
end

local function sum(a, b, ...)
    if b == nil then
        return a
    else
        return sum(a + b, ...)
    end
end

local aliquot = (function()
    local function do_aliquot(n, current, ...)
        if n == 1 then
            return 0
        end
        if not current then
            return do_aliquot(n, 1)
        end
        if current >= n then
            return ...
        end
        if divisible(n, current) then
            return do_aliquot(n, current + 1, current, ...)
        else
            return do_aliquot(n, current + 1, ...)
        end
    end

    return function(n)
        return do_aliquot(n, 1)
    end
end)()

local function aliquot_sum(n)
    return sum(aliquot(n))
end

local function classify(n)
    if aliquot_sum(n) < n then
        return "deficient"
    elseif aliquot_sum(n) == n then
        return "perfect"
    else
        return "abundant"
    end
end

return { aliquot_sum = aliquot_sum, classify = classify }
