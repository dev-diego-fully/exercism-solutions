local one_gigasecond = (10 ^ 9)

local gigasecond = {}

function gigasecond.anniversary(any_date)
    return os.date("%x", any_date + one_gigasecond)
end

return gigasecond
