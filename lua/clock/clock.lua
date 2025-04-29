--- Number of minutes in an hour
local MINUTES_IN_HOUR <const> = 60
--- Amount of minutes in a day
local MINUTES_IN_DAY <const> = 24 * 60
--- Format in which the clock is displayed HH:MM
local FORMAT <const> = "%02d:%02d"

--- @class Clock
--- @field total_minutes number
--- @field minutes number
--- @field hours number
--- @field minus fun(self: Clock, minutes: number):Clock
--- @field plus fun(self: Clock, minutes: number):Clock
local Clock = {}
local at, clamp_time, imutable_error, new, new_meta, tostring;

--- Returns a clock instance from the given hour and minutes.
--- @param hours number
--- @param minutes number?
--- @returns Clock
function at(hours, minutes)
    minutes = minutes or 0
    return new(hours * MINUTES_IN_HOUR + minutes)
end

--- Returns a copy of this clock with the amount of time equal to the amount
--- of minutes provided plus the amount of time given.
--- @param minutes number Number of minutes added
--- @return Clock
function Clock:plus(minutes)
    return new(self.total_minutes + minutes)
end

--- Returns a copy of this clock with the given amount of minutes subtracted
--- from this clock.
--- @param minutes number Amount of minutes subtracted
--- @return Clock
function Clock:minus(minutes)
    return new(self.total_minutes - minutes)
end

--- Returns whether or not the given other clock is equal to this one. They
--- are equal if they show the same hours and minutes.
--- @param other any
--- @return boolean
function Clock:equals(other)
    return self.total_minutes == other.total_minutes
end

--- Returns the representation of this clock as a string. Format: HH:MM
--- @param self Clock
--- @return string
function tostring(self)
    return string.format(
        FORMAT, self.hours, self.minutes
    )
end

--- Returns a new clock instance from the given total number of minutes.
--- @param minutes number
--- @return Clock
function new(minutes)
    return setmetatable(
        {},
        new_meta(
            clamp_time(minutes)
        )
    )
end

--- Raises an error stating that it is not possible to modify the object.
function imutable_error()
    error("Can't modify a immutable object.")
end

--- Clamp and Wrap the amount of minutes passed to fit within the amount
--- of minutes in a day.
--- @param minutes number Total number of minutes
--- @return number 
function clamp_time(minutes)
    return minutes % MINUTES_IN_DAY
end

--- Creates a new metatable for a Clock using the total number of minutes
--- in it. This metatable's main purpose is to make the object immutable.
---@param total_minutes number
---@return table
function new_meta(total_minutes)
    local hours = math.floor(total_minutes / MINUTES_IN_HOUR)
    local minutes = total_minutes % MINUTES_IN_HOUR

    return {
        __index = function(_, index)
            if index == "total_minutes" then
                return total_minutes
            elseif index == "minutes" then
                return minutes
            elseif index == "hours" then
                return hours
            else
                return Clock[index]
            end
        end,
        __newindex = imutable_error,
        __tostring = tostring
    }
end

return {
    at = at
}
