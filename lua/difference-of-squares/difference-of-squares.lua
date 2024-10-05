local square_of_sum = (function()
    local function square_of_sum(n, squares_sum)
        if n > 0 then
            return square_of_sum(n - 1, squares_sum + n)
        else
            return squares_sum ^ 2
        end
    end

    return function(n)
        return square_of_sum(n, 0)
    end
end)()


local sum_of_squares = (function()
    local function sum_of_squares(n, sum_squares)
        if n > 0 then
            return sum_of_squares(n - 1, sum_squares + n ^ 2)
        else
            return sum_squares
        end
    end

    return function(n)
        return sum_of_squares(n, 0)
    end
end)()

local function difference_of_squares(n)
    return square_of_sum(n) - sum_of_squares(n)
end

return {
    square_of_sum = square_of_sum,
    sum_of_squares = sum_of_squares,
    difference_of_squares = difference_of_squares
}
