local color_code, colors_value;

--- @alias ResistorColor
---| "black"
---| "brown"
---| "red"
---| "orange"
---| "yellow"
---| "green"
---| "blue"
---| "violet"
---| "grey"
---| "white"

--- Retrieves the numeric value associated with a specific resistor color.
--- @param color ResistorColor The name of the color to look up.
--- @return integer - The corresponding numeric code (0-9).
function color_code(color)
  return colors_value[color]
end

--- Internal mapping of resistor color names to their respective integer codes.
--- @type table<ResistorColor, integer>
colors_value = {
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

return {
  color_code = color_code
};
