local Direction = require("direction")
local switch = require("switch")

--- Class represents a robot in the simulation. It has an x ​​and y
--- coordinate. It also has a direction in which it is facing. Its move
--- method executes a set of commands given by each character of the
--- sequence string.
---@class Robot
---@field x integer
---@field y integer
---@field heading Direction
---@field move fun(self: Robot, sequence: string)
local Robot = {}

--reservings
local new
local turnLeft, turnRight, advance

local increase_x, increase_y, decrease_x, decrease_y
local error_invalid_command
local advance_switcher, command_switcher

--PUBLICS

--- Returns a new Robot instance with the settings given by the input table.
--- @param config {x: integer, y: integer, heading: Direction}
--- @return Robot
function new(config)
    return {
        x = config.x,
        y = config.y,
        heading = config.heading,
        move = Robot.move
    }
end

--- Attempts to execute each command present in the sequence string.
--- Executes each possible command until an invalid command is found or
--- the end of the sequence is reached. If an invalid command is found,
--- the execution is aborted and an error is raised. All side effects of
--- operations prior to the error are maintained.
---
--- The valid commands are:
---
--- L- (Left) Turn left
---
--- R- (Right) Turn right
---
--- A- (Advance) Move forward.
--- @param sequence string
function Robot:move(sequence)
    for command in sequence:gmatch(".") do
        local operation = command_switcher(command)

        assert(operation ~= nil, error_invalid_command(command))
        operation(self)
    end
end

--PRIVATES

--- Rotates the Robot die 90 degrees to the left (counterclockwise).
--- @param self Robot
function turnLeft(self)
    self.heading = Direction.rotate_counter_clock(self.heading)
end

--- Rotates the Robot dice 90 degrees to the right (clockwise)
--- @param self Robot
function turnRight(self)
    self.heading = Direction.rotate_clock(self.heading)
end

--- Advances the given robot forward. The impact this has on the position
--- depends on the direction the robot is facing at the time of advancement.
--- @param self Robot
function advance(self)
    advance_switcher(self.heading)(self)
end

--- Increments the X axis, which is equivalent to moving one to the north.
--- @param self Robot
function increase_x(self) self.x = self.x + 1 end

--- Decreases the X axis, which is equivalent to moving one to the south.
--- @param self Robot
function decrease_x(self) self.x = self.x - 1 end

--- Increments the Y axis, which is equivalent to moving one to the east.
--- @param self Robot
function increase_y(self) self.y = self.y + 1 end

--- Decreases the Y axis, which is equivalent to moving one to the west.
--- @param self Robot
function decrease_y(self) self.y = self.y - 1 end

--- Given a direction, returns the equivalent move operation.
--- @type fun(Direction):fun(self:Robot)
advance_switcher = switch(
    Direction.values,
    { increase_y, increase_x, decrease_y, decrease_x }
)

--- Given a character, returns the Robot operation equivalent to it.
--- If no match is found, returns nil.
--- @type fun(Direction):fun(self:Robot)
command_switcher = switch(
    { "L", "R", "A" },
    { turnLeft, turnRight, advance }
)

---Given a command, returns an error message saying that this command is
---invalid. Expect this command to be one character, but that's not critical.
---@param command string
---@return string
function error_invalid_command(command)
    return "invalid command \"" .. command .. "\"."
end

--exporting
return new
