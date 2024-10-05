local number = {
    is_even = function(x)
        return x % 2 == 0
    end,
    is_postive = function(x)
        return x > 0
    end,
    is_integer = function(x)
        return math.floor(x) == x
    end
}

local collatz = {}

function collatz.number(x)
    if number.is_even(x) then
        return x / 2
    else
        return 3 * x + 1
    end
end

function collatz.steps(x, prev_steps)
    if x == 1 then
        return prev_steps
    else
        return collatz.steps(collatz.number(x), prev_steps + 1)
    end
end

return function(n)
    assert(
        number.is_postive(n) and number.is_integer(n),
        "Only positive numbers are allowed"
    )
    return collatz.steps(n, 0)
end
