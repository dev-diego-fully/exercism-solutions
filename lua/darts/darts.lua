local Darts = {}

local scores = {
    outside = 0,
    outer = 1,
    middle = 5,
    inner = 10
}
local radius = {
    inner = 1,
    middle = 5,
    outer = 10
}

function Darts.score(x, y)
    local distance_from_center = math.sqrt(x ^ 2 + y ^ 2)

    if distance_from_center <= radius.inner then
        return scores.inner
    elseif distance_from_center <= radius.middle then
        return scores.middle
    elseif distance_from_center <= radius.outer then
        return scores.outer
    else
        return scores.outside
    end
end

return Darts
