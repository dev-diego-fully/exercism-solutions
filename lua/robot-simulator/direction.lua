local switch <const> = require("switch")

--- Represents the cardinal directions. They can be rotated, returning a
--- new direction.
---@enum Direction
local Direction <const> = {
    NORTH = "north",
    EAST = "east",
    SOUTH = "south",
    WEST = "west"
}

--- Vector containing all supported cardinal directions.
--- @type Direction[]
local DIRECTIONS <const> = {
    Direction.NORTH, Direction.EAST, Direction.SOUTH, Direction.WEST
};

--- Returns the result (direction) of a 90 degree clockwise rotation
--- from the given direction.
--- @type fun(value:Direction):Direction
local rotate_clock <const> = switch(
    DIRECTIONS,
    { Direction.EAST, Direction.SOUTH, Direction.WEST, Direction.NORTH }
)

--- Returns the result of a rotation (direction) of a 90 degree
--- counterclockwise rotation from the given direction.
--- @type fun(value:Direction):Direction
local rotate_counter_clock <const> = switch(
    DIRECTIONS,
    { Direction.WEST, Direction.NORTH, Direction.EAST, Direction.SOUTH }
)

return {
    values = DIRECTIONS,
    rotate_clock = rotate_clock,
    rotate_counter_clock = rotate_counter_clock
}
