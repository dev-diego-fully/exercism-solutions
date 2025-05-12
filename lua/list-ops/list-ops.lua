--- Applies the reduction function to all elements of the list, from left to
--- right. Considers value as the initial value of the operation (the first
--- element of the view will see value as the previous value).
---
--- @generic T, U
--- @param xs T[]
--- @param value U
--- @param f fun(current: T, acc: U): U
--- @return U
local function reduce(xs, value, f)
    local result = value

    for _, v in ipairs(xs) do
        result = f(v, result)
    end

    return result
end

--- Transforms each element of the passed list using the transform function.
--- The new result is still a vector.
---
--- @generic T, U
--- @param xs T[]
--- @param f fun(value:T):U
--- @return U[]
local function map(xs, f)
    local result = {}

    for i, v in ipairs(xs) do
        result[i] = f(v)
    end

    return result
end

--- Filters the elements of the list using the predicate function.
--- 
--- @generic T
--- @param xs T[]
--- @param pred fun(value: T):boolean
--- @return T[]
local function filter(xs, pred)
    local result = {}

    for _, v in ipairs(xs) do
        if pred(v) then
            table.insert(result, v)
        end
    end

    return result
end

return { map = map, reduce = reduce, filter = filter }
