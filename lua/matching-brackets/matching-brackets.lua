--- A module for checking if brackets in a string are correctly matched and balanced.
local matching_brackets <const> = {}
--- A table containing helper functions and constants for bracket matching logic.
local brackets <const> = {}

--- Checks if a string contains correctly matched and balanced brackets.
--- The function uses a stack-based approach to validate the nesting of brackets.
--- It iterates through the string, pushing opening brackets onto a stack and popping them when a matching closing bracket is found.
--- @param str string The string to be checked.
--- @return boolean -- True if all brackets are valid and balanced, false otherwise.
function matching_brackets.valid(str)
  local stack <const> = {}

  for bracket in brackets.brackets(str) do
    if brackets.is_opener(bracket) then
      table.insert(stack, bracket)
    elseif not brackets.closes(bracket, table.remove(stack)) then
      return false
    end
  end

  return #stack == 0
end

--- Returns an iterator that yields all bracket characters from a string.
--- The iterator finds all instances of `(`, `)`, `[`, `]`, `{`, and `}`.
--- @param str string The string to iterate through.
--- @return fun():string -- An iterator that returns the next bracket character.
function brackets.brackets(str)
  return str:gmatch("[%(%)%[%]%{%}]")
end

--- Checks if a given character is an opening bracket.
--- @param bracket string The character to check.
--- @return boolean -- True if the character is an opening bracket, false otherwise.
function brackets.is_opener(bracket)
  return bracket:match("[%[%(%{]") ~= nil
end

--- A constant map that links each closing bracket to its corresponding opening bracket.
local close_map <const> = {
  ["}"] = "{",
  ["]"] = "[",
  [")"] = "("
}

--- Checks if a closing bracket correctly matches a given opening bracket.
--- @param bracket string The closing bracket.
--- @param opener string The opening bracket from the stack.
--- @return boolean -- True if the brackets are a matching pair, false otherwise.
function brackets.closes(bracket, opener)
  return close_map[bracket] == opener
end

return matching_brackets