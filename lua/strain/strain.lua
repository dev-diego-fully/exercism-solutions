--- A module for filtering arrays based on a predicate function.
local strain <const> = {}

--- Filters a array, returning a new array containing only the elements
--- for which the predicate function returns true.
--- @generic T The type of elements in the array.
--- @param xs T[] The array to filter.
--- @param pred fun(value: T):boolean The predicate function to apply to each element.
--- @return T[] -- A new array with the filtered elements.
function strain.keep(xs, pred)
    local result = {}

    for _, v in ipairs(xs) do
        if pred(v) then
            table.insert(result, v)
        end
    end

    return result
end

--- Filters a array, returning a new array containing only the elements
--- for which the predicate function returns false.
--- @generic T The type of elements in the array.
--- @param xs T[] The array to filter.
--- @param pred fun(value: T):boolean The predicate function to apply to each element.
--- @return T[] -- A new array with the filtered elements.
function strain.discard(xs, pred)
    local result = {}

    for _, v in ipairs(xs) do
        if not pred(v) then
            table.insert(result, v)
        end
    end

    return result
end

return strain