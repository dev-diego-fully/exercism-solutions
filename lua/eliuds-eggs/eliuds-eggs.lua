local EliudsEggs = {}

local function bits(number, ...)
    if number > 0 then
        return bits(number // 2, number % 2, ...)
    else
        return {...}
    end
end

local function appearences(vec, elem)
    local map = {}
    for _, v in ipairs(vec) do
        map[v] = (map[v] or 0) + 1
    end
    return map[elem]
end

function EliudsEggs.egg_count(number)
    local eggs = 1
    local no_eggs = 0
    return appearences( bits(number), eggs ) or no_eggs
end

return EliudsEggs