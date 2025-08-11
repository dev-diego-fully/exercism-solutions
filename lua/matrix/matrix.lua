--- A helper function that splits a string into a table of substrings based on a separator.
--- @param str string The string to split.
--- @param sep string The separator character.
--- @return string[] A table of the resulting substrings.
local function str_split(str, sep)
    local result = {}

    for match in str:gmatch("([^" .. sep .. "]+)") do
        table.insert(result, match)
    end

    return result
end

--- A helper function that converts a table of strings to a table of numbers.
--- @param arr string[] The table of strings.
--- @return number[] The table with elements converted to numbers.
local function map_to_number(arr)
    local result = {}

    for i, elem in pairs(arr) do
        result[i] = tonumber(elem)
    end

    return result
end

--- Parses a multi-line string into a two-dimensional table of numbers.
--- @param matrix string The matrix as a multi-line string.
--- @return integer[][] A table representing the matrix.
local function parse_matrix(matrix)
    local result = {}

    for _, line in ipairs(str_split(matrix, "\n")) do
        table.insert(result, map_to_number(str_split(line, " ")))
    end

    return result
end


--- Retrieves a specific row from a matrix.
--- @param matrix integer[][] The matrix to operate on.
--- @param index integer The 1-based index of the row to retrieve.
--- @return integer[] The requested row as a new table.
local function row(matrix, index)
    return { table.unpack(matrix[index]) }
end

--- Retrieves a specific column from a matrix.
--- @param matrix integer[][] The matrix to operate on.
--- @param index integer The 1-based index of the column to retrieve.
--- @return integer[] The requested column as a new table.
local function column(matrix, index)
    local col = {}
    local len = #matrix

    for i = 1, len, 1 do
        table.insert(col, matrix[i][index])
    end

    return col
end

--- Creates a matrix object from a string representation.
--- @param s string The string representing the matrix.
--- @return {row: fun(index: integer): integer[], column: fun(index: integer):integer[]}
return function(s)
    local matrix = parse_matrix(s)

    return {
        --- Retrieves a specific row from the matrix.
        --- @param index integer
        --- @return integer[]
        row = function(index)
            return row(matrix, index)
        end,
        --- Retrieves a specific column from the matrix.
        --- @param index integer
        --- @return integer[]
        column = function(index)
            return column(matrix, index)
        end
    }
end