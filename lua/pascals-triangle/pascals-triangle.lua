--- Private helper functions for the Pascal's Triangle module.
local triangle, triangle_row, triangle_element, factorial

--- Generates a full Pascal's Triangle up to the specified number of rows.
--- @param rows integer The number of rows to generate.
--- @return integer[][] triangle A two-dimensional table representing the triangle.
function triangle(rows)
    local trig = {}

    for n = 1, rows, 1 do
        table.insert(trig, triangle_row(n))
    end

    return trig
end

--- Generates a single row of Pascal's Triangle.
--- Each element is calculated using the binomial coefficient formula, "n choose k".
--- @param n integer The row number (1-based).
--- @return integer[] row A table representing the row.
function triangle_row(n)
    local elements = {}

    for i = 1, n, 1 do
        table.insert(elements, triangle_element(n - 1, i - 1))
    end

    return elements
end

--- Calculates a single element of Pascal's Triangle using the binomial coefficient formula.
--- This is equivalent to "n choose k" or C(n, k).
--- @param n integer The row number (0-based).
--- @param k integer The element number within the row (0-based).
--- @return integer -- The calculated element value.
function triangle_element(n, k)
    local fat_n = factorial(n)
    local fat_k = factorial(k)
    local fat_diff = factorial(n - k)

    return fat_n / (fat_k * fat_diff)
end

--- Calculates the factorial of a non-negative integer.
--- @param n integer The number to calculate the factorial of.
--- @return integer -- The factorial of n.
function factorial(n)
    if n <= 0 then
        return 1
    end
    local fat = 1

    for i = 1, n, 1 do
        fat = fat * i
    end

    return fat
end

--- A factory function that creates an object representing Pascal's Triangle.
--- The object's fields are generated on demand.
--- @param n integer The number of rows for the triangle.
--- @return {rows: integer[][], last_row: integer[]} -- An object with the full triangle and the last row.
return function(n)
    return setmetatable(
        {},
        {
            __index = function(self, index)
                if index == "rows" then
                    return triangle(n)
                elseif index == "last_row" then
                    return triangle_row(n)
                end
            end
        }
    )
end
