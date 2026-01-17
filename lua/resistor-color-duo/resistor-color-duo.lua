local band_value, color_value, colors_values;
local UNITY_INDEX, DECIMAL_INDEX, BAND_POW;

--- Calculates the combined resistance value of the first two bands of a resistor.
--- @param band_colors ResistorColor[] A table containing the list of color names.
--- @return integer # The two-digit resistance value.
function band_value(band_colors)
  return (
    color_value(band_colors[DECIMAL_INDEX], DECIMAL_INDEX) +
    color_value(band_colors[UNITY_INDEX], UNITY_INDEX)
  );
end

--- Calculates the weighted value of a single color band based on its position.
--- @param color ResistorColor The name of the color band.
--- @param color_index integer The 1-based index of the band (1 for decimal, 2 for unity).
--- @return number # The calculated value for that specific band.
function color_value(color, color_index)
  return colors_values[color] * BAND_POW ^ (UNITY_INDEX - color_index)
end

UNITY_INDEX, DECIMAL_INDEX, BAND_POW = 2, 1, 10;

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
--- Mapping of resistor color names to their respective integer codes.
--- @type table<ResistorColor, integer>
colors_values = {
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
};

return {
  value = band_value
};
