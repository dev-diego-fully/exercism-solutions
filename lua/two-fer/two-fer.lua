--@module TwoFer 
local TwoFer = {}

--- Output message format
local message_format <const> = "One for %s, one for me."
--- 
local default_pronoun <const> = "you"

--- Returns a message in the format "One for <name>, one for me". If no name
--- is provided, the person is referred to as "you".
-- @param name string? Person's name
-- @return string Formatted message 
function TwoFer.two_fer(name)
    local pronoun = name or default_pronoun

    return string.format(message_format, pronoun)
end

return TwoFer
