table.unpack = table.unpack or unpack;

local Self = {}

function Self.scores(self)
    return { table.unpack(self._scores) };
end

function Self.personal_best(self)
    return math.max(
        table.unpack(self._scores)
    )
end

function Self.personal_top_three(self)
    local best = self:scores()
    table.sort(best, function (a, b) return a > b end)
    return { best[1], best[2], best[3] }
end

function Self.latest(self)
    return self._scores[#self._scores]
end

local meta = {
    __index = Self,
    __newindex = function()
        error("Try to modify a immutable table.")
    end
}

return function(scores)
    assert(
        type(scores) == "table",
        "Invalid type for arguments scores, expects a table got" ..
        type(scores) .. "."
    )

    local self = {}

    self._scores = { table.unpack(scores) };
    setmetatable(self, meta)

    return self
end
