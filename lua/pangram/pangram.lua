---------------modules declaration---------------

local letters = {}
local list = {}

---------------letters---------------

function letters.letters(str)
    local letters = {}
    for letter in str:lower():gmatch("%a") do
        table.insert(letters, letter)
    end
    return letters
end

function letters.alphabet()
    local i = 0
    return function()
        if i < 26 then
            i = i + 1
            return string.char(96 + i)
        end
        return
    end
end

function letters.is_pangram(s)
    local letters_ = letters.letters(s)
    for letter in letters.alphabet() do
        if not list.contains(letters_, letter) then
            return false
        end
    end
    return true
end

---------------list---------------

function list.contains(list, elem)
    for _, v in ipairs(list) do
        if v == elem then
            return true
        end
    end
    return false
end

---------------exports---------------

return letters.is_pangram
