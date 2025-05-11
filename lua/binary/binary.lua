---Given a string representing a binary number, returns the decimal value of
---the number represented in it. If the representation is not valid as
---binary, returns 0.
---@param input string
---@return integer
local function to_decimal(input)
    local digits = #input
    local decimal = 0
    local pos = digits

    for digit in input:gmatch(".") do
        if digit == "1" then
            decimal = decimal + 2 ^ (pos - 1)
        elseif digit ~= "0" then
            return 0
        end
        pos = pos - 1
    end

    return decimal
end

return { to_decimal = to_decimal }
