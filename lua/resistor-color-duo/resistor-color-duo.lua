local colors_values = {
  black = 0,
  brown = 1,
  red = 2,
  orange = 3,
  yellow = 4,
  green = 5,
  blue = 6,
  violet = 7,
  grey = 8,
  white = 9
}

local function value(color, position)
  return colors_values[color] * 10 ^ (2 - position)
end

return {
  value = function(colors)
    return value(colors[1], 1) + value(colors[2], 2)
  end
}
