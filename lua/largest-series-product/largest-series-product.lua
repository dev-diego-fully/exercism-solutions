--- A submodule for finding the largest product of a series of digits within a number string.
local string_number <const> = {}
--- A submodule for generic iterator-based operations.
local iters <const> = {}
--- A submodule for common list operations.
local lists <const> = {}

--- Calculates the largest product of a contiguous series of digits of a given length.
---
--- It will throw an error if:
--- - `digits` is not a string containing only digits.
--- - `span` is less than or equal to 0.
--- - `span` is greater than the number of digits.
---
--- The function works by converting the string to a list of digits, creating an iterator
--- that yields all possible slices of the specified length, mapping each slice to its product,
--- and finally finding the maximum value from the resulting products.
--- @param args {digits: string, span: integer} An object containing the number string and the
--- span length.
--- @return number -- The largest product found.
local function largest_series_product(args)
    assert(string_number.is_number(args.digits), "invalid digits")
    assert(args.span > 0, "invalid negative span")
    assert(args.span <= #args.digits, "span can't be greater than number's digits count")

    local digits <const> = string_number.to_digits(args.digits)

    return iters.max(
        iters.map(lists.slices(digits, args.span), lists.product)
    )
end

--- Creates a new iterator by applying a `mapper` function to each element yielded by a source `iter`.
--- @generic T, U
--- @param iter fun(): T The source iterator.
--- @param mapper fun(elem: T): U The function to apply to each element.
--- @return fun(): U -- A new iterator yielding the transformed elements.
function iters.map(iter, mapper)
    return function()
        local current = iter()
        if current ~= nil then
            return mapper(current)
        end
    end
end

--- Finds the maximum value yielded by an iterator.
--- @param iter fun():number An iterator that yields numbers.
--- @return number -- The highest number yielded by the iterator.
function iters.max(iter)
    local higher = iter()
    local current = iter()

    while current ~= nil do
        if current > higher then
            higher = current
        end
        current = iter()
    end

    return higher
end

--- Checks if a string contains only digit characters.
--- @param s string The string to check.
--- @return boolean -- True if the string is a number, false otherwise.
function string_number.is_number(s)
    return s:match("[^%d]") == nil
end

--- Converts a string of digits into a table of integer numbers.
--- @param num string The number string.
--- @return integer[] -- A table where each element is a digit from the input string.
function string_number.to_digits(num)
    local digs = {}

    for digit in num:gmatch("%d") do
        table.insert(digs, digit)
    end

    return digs
end

--- Creates an iterator that yields contiguous slices of a given table.
--- @generic T
--- @param num T[] The input table.
--- @param span integer The length of each slice.
--- @return (fun():T[]) -- An iterator yielding the slices.
function lists.slices(num, span)
    local index = 0
    local limit = #num - span

    local function next(_, _)
        if index <= limit then
            index = index + 1
            return { table.unpack(num, index, index + span - 1) }
        end
    end

    return next
end

--- Calculates the product of all numbers in a table.
--- @param numbers number[] The table of numbers.
--- @return number -- The product of all numbers in the table.
function lists.product(numbers)
    local result = 1

    for _, num in ipairs(numbers) do
        result = result * num
    end

    return result
end

return largest_series_product