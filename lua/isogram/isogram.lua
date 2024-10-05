local char = {}
local vector = {}

function char.at(s, i)
    return string.sub(s, i, i)
end

function char.chars(s)
    local chars = {}

    for i = 1, #s, 1 do
        table.insert(chars, char.at(s, i))
    end

    return chars
end

function char.rejector(chars)
    local rejecteds = { table.unpack(chars) }
    return function(c)
        return vector.contains(rejecteds, c)
    end
end

function vector.filter(vec, filter_fn)
    local filtered = {}
    for _, v in ipairs(vec) do
        if filter_fn(v) then
            table.insert(filtered, v)
        end
    end
    return filtered
end

function vector.contains(vec, elem)
    for _, v in ipairs(vec) do
        if v == elem then
            return false
        end
    end

    return true
end

function vector.appearences(vec)
    local map = {}

    for _, v in ipairs(vec) do
        map[v] = (map[v] or 0) + 1
    end

    return map
end

return function(s)
    local map = vector.appearences(
        vector.filter(
            char.chars(string.lower(s)),
            char.rejector({ " ", "-" })
        )
    )

    for _, v in pairs(map) do
        if v > 1 then
            return false
        end
    end

    return true
end
