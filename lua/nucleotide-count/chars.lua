local list = require "list"
local chars = {}

function chars.at(str, pos)
    return string.sub(str, pos, pos)
end

function chars.get(str)
    local chars_ = {}

    for i = 1, #str, 1 do
        table.insert(chars_, chars.at(str, i))
    end

    return chars_
end

return chars
