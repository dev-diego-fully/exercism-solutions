local color_values = {
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
  if position <= 2 then
    return color_values[color] * 10 ^ (2 - position)
  else
    return 10 ^ color_values[color]
  end
end

local function to_metric_ohms(value)
  if value < 10 ^ 3 then
    return value, "ohms"
  elseif value < 10 ^ 6 then
    return value / 10 ^ 3, "kiloohms"
  elseif value < 10 ^ 9 then
    return value / 10 ^ 6, "megaohms"
  else
    return value / 10 ^ 9, "gigaohms"
  end
end

return {
  decode = function(c1, c2, c3)
    return to_metric_ohms(
      ((value(c1, 1) + value(c2, 2)) * value(c3, 3))
    )
  end
}
