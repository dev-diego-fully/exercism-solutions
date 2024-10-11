local alphabet_size = 26
local upper_case_start = 65
local lower_case_start = 97

local function is_lower(char_code)
  local lower_case_end = lower_case_start + alphabet_size
  return lower_case_start <= char_code and char_code <= lower_case_end
end

local function is_upper(char_code)
  local upper_case_end = upper_case_start + alphabet_size
  return upper_case_start <= char_code and char_code <= upper_case_end
end

local function letter_rotate(letter_pos, rotation)
  return (letter_pos - 1 + rotation) % alphabet_size + 1
end

local function rotate(char, key)
  local case_start = 0
  local char_code = string.byte(char)
  if is_upper(char_code) then
    case_start = upper_case_start
  elseif is_lower(char_code) then
    case_start = lower_case_start
  else
    return char
  end
  local letter_pos = char_code - case_start + 1
  return string.char(letter_rotate(letter_pos, key) + case_start - 1)
end

local function get_char(str, index)
  return string.sub(str, index, index)
end

return {
  rotate = function(input, key)
    local output = ""
    for i = 1, #input, 1 do
      output = output .. rotate(get_char(input, i), key)
    end
    return output
  end
}
