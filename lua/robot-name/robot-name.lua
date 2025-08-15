local random = require("random")

--- A public interface for a Robot object.
--- The name is generated lazily upon first access.
--- @class Robot
--- @field name string The unique name of the robot.
local Robot <const> = {}

--- The internal representation of a Robot object.
--- This class manages the state and logic for name generation.
--- @class PrivRobot : Robot
--- @field _name string The robot's unique name, or `nil` if not yet generated.
local PrivRobot <const> = {}

--- The public constructor for a new Robot instance.
--- @return Robot -- A new Robot instance.
function Robot:new()
    return PrivRobot._new()
end

--- Resets the robot's name.
--- The next time the `name` field is accessed, a new unique name will be generated.
--- @param self Robot
function Robot.reset(self)
    ---@cast self PrivRobot
    self._name = nil
end

--- The string format used to generate robot names (two uppercase letters followed by three digits).
PrivRobot._NAME_FORMAT = "%s%s%03d"
--- A table to keep track of all names that are currently in use.
PrivRobot._NAMES_IN_USED = {}

--- The internal constructor for a new PrivRobot instance.
--- @return PrivRobot -- A new PrivRobot instance.
function PrivRobot._new()
    return setmetatable({}, PrivRobot)
end

--- Generates a random name string following the specified format.
--- @return string -- A random name string.
function PrivRobot._random_name()
    return PrivRobot._NAME_FORMAT:format(
        random.upper_case(), random.upper_case(),
        random.integer(1, 999)
    )
end

--- Finds and assigns a unique name to the robot instance.
--- The function generates random names until it finds one that is not in use.
--- @param self PrivRobot
function PrivRobot._get_random_name(self)
    while true do
        local name = PrivRobot._random_name()
        if PrivRobot._NAMES_IN_USED[name] == nil then
            self._name = name
            return
        end
    end
end

--- The `__index` metamethod for the robot object.
--- This method provides lazy initialization for the `name` field, generating it
--- only when it is first accessed.
--- @param robot PrivRobot The robot instance.
--- @param index any The key being accessed.
--- @return any -- The value of the requested key.
function PrivRobot.__index(robot, index)
    if index == "name" then
        if robot._name == nil then
            robot:_get_random_name()
        end
        return robot._name
    end
    return Robot[index] or PrivRobot[index]
end

return Robot