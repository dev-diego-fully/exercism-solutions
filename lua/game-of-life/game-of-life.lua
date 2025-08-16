--- A module for simulating Conway's Game of Life.
local game_of_life <const> = {}

local next_life_state, alive_neighbours_count, neighbours_of, reject

--- A type alias representing the game board, which is a two-dimensional array of `LifeState` values.
--- @alias GameState LifeState[][]
--- An enumeration defining the two possible states for a cell in the game.
--- @enum LifeState
local LifeState <const> = {
    Dead = 0,
    Alive = 1
}

--- Advances the game state by one generation (or "tick").
--- This function calculates the next state for every cell on the board based on the rules of the Game of Life.
--- @param state GameState The current state of the game board.
--- @return GameState -- A new game state representing the next generation.
function game_of_life.tick(state)
    local result = {}

    for y = 1, #state, 1 do
        result[y] = {}
        for x = 1, #state[1], 1 do
            result[y][x] = next_life_state(state, x, y)
        end
    end

    return result
end

--- Determines the next state of a single cell based on the rules of the Game of Life.
--- A dead cell with exactly 3 alive neighbors becomes alive. An alive cell with 2 or 3 alive neighbors remains alive. All other cells die.
--- @param state GameState The current state of the game board.
--- @param x integer The x-coordinate of the cell.
--- @param y integer The y-coordinate of the cell.
--- @return LifeState -- The new state of the cell.
function next_life_state(state, x, y)
    local alive_neighbours = alive_neighbours_count(state, x, y)

    if alive_neighbours == 3 then
        return LifeState.Alive
    elseif state[y][x] == LifeState.Alive and alive_neighbours == 2 then
        return LifeState.Alive
    else
        return LifeState.Dead
    end
end

--- Counts the number of alive neighbors for a specific cell.
--- @param state GameState The current state of the game board.
--- @param x integer The x-coordinate of the cell.
--- @param y integer The y-coordinate of the cell.
--- @return integer -- The number of alive neighbors.
function alive_neighbours_count(state, x, y)
    local count = 0

    for _, neighbour in ipairs(neighbours_of(#state[1], #state, x, y)) do
        if state[neighbour.y][neighbour.x] == LifeState.Alive then
            count = count + 1
        end
    end

    return count
end

--- Returns a table of valid coordinates for all direct neighbors of a cell.
--- The list excludes the cell itself and any coordinates that are outside the board boundaries.
--- @param width integer The width of the game board.
--- @param height integer The height of the game board.
--- @param x integer The x-coordinate of the cell.
--- @param y integer The y-coordinate of the cell.
--- @return {x: integer, y: integer}[] -- A table of neighbor coordinates.
function neighbours_of(width, height, x, y)
    local neighbours = {}

    for i = y - 1, y + 1, 1 do
        for j = x - 1, x + 1, 1 do
            table.insert(neighbours, { x = j, y = i })
        end
    end

    return reject(neighbours, function(coord)
        return (
            coord.x < 1 or coord.y < 1 or
            coord.x > width or coord.y > height or
            (coord.x == x and coord.y == y)
        )
    end)
end

--- A general-purpose helper function that filters a list based on a rejection function.
--- @param list table The list to filter.
--- @param rejecter function The function that returns `true` for elements to be rejected.
--- @return table -- A new list containing only the elements that were not rejected.
function reject(list, rejecter)
    local result = {}

    for _, elem in ipairs(list) do
        if not rejecter(elem) then
            table.insert(result, elem)
        end
    end

    return result
end

return game_of_life