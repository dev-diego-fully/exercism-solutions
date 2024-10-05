local list = {}

function list.appearances(li)
    local map = {}

    for _, v in ipairs(li) do
        map[v] = (map[v] or 0) + 1
    end

    return map
end

function list.every(li, callback)
    for _, v in ipairs(li) do
        if not callback(v) then
            return false
        end
    end
    return true
end

function list.some(li, callback)
    for _, v in ipairs(li) do
        if callback(v) then
            return true
        end
    end
    return false
end

function list.includes(li, elem)
    return list.some(
        li,
        function(v)
            return v == elem
        end
    )
end

function list.count(li, elem)
    local count = 0
    for _, v in ipairs(li) do
        if v == elem then
            count = count + 1
        end
    end
    return count
end

return list
