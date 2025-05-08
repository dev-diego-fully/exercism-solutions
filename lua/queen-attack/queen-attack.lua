---Class represents a queen on the board. It has a coordinate within the
---board and a method to check if it can attack another piece (another
---queen, in this case).
---@class Queen
---@field row integer
---@field column integer
---@field can_attack fun(Queen):boolean

---Lowest value on the axis that a coordinator can have.
local BOARD_START = 0
---Highest value on the axis that a coordinator can have.
local BOARD_END = 7

local new, can_attack
local shares_column, shares_diagonal, shares_row

---Creates a new instance of Queen, with the column and row given by
---the argument table.
---@param pos {row: integer, column: integer}
---@return Queen
function new(pos)
    assert(pos.row ~= nil, "missing row")
    assert(pos.column ~= nil, "missing column")

    assert(pos.row >= BOARD_START, "row underflow")
    assert(pos.column >= BOARD_START, "column underflow")

    assert(pos.row <= BOARD_END, "row overflow")
    assert(pos.column <= BOARD_END, "column overflow")

    local self = { row = pos.row, column = pos.column }

    ---Returns whether or not this queen can attack the given queen "other".
    ---@param other Queen
    ---@return boolean
    function self.can_attack(other)
        return can_attack(self, other)
    end

    return self
end

---Returns whether or not the first queen can attack the second.
---@param self Queen
---@param other Queen
---@return boolean
function can_attack(self, other)
    return shares_column(self, other) or
        shares_row(self, other) or
        shares_diagonal(self, other)
end

---Returns whether the first queen and the second queen are on the same
---column of the board
---@param self Queen
---@param other Queen
---@return boolean
function shares_column(self, other)
    return self.column == other.column
end

---Returns whether or not the first and second queens are on the same
---diagonal of the board.
---@param self Queen
---@param other Queen
---@return boolean
function shares_diagonal(self, other)
    local cols_distance = math.abs(self.column - other.column)
    local rows_distance = math.abs(self.row - other.row)

    return cols_distance == rows_distance
end

---Returns whether or not the first and second queens are on the same
---line of the board.
---@param self Queen
---@param other Queen
---@return boolean
function shares_row(self, other)
    return self.row == other.row
end

return new
