--- A module for performing data transformations, such as inverting a table's structure.
local etl <const> = {}

--- Transforms an old score table into a new one.
--- It inverts the key-value relationship, making the letters the new keys and their scores the values.
--- All letters are converted to lowercase.
--- @param scores table<integer, string[]> A table where keys are scores and values are tables of letters.
--- @return table<string, integer> A new table where keys are lowercase letters and values are their scores.
function etl.transform(scores)
  local transformed = {}

  for score, set in pairs(scores) do
    for _, letter in ipairs(set) do
      transformed[letter:lower()] = score
    end
  end

  return transformed
end

return etl