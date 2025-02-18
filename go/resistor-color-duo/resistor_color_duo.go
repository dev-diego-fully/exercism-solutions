// Package resistorcolorduo provides functions to obtain the resistance value
// of resistors with two color bands.
package resistorcolorduo

// Value should return the resistance value of a resistor with a given colors.
// Returns INVALID_BAND_CONFIGURATION when receiving invalid colors or
// less than two color bands.
func Value(colors []string) int {
	if len(colors) < 2 {
		return INVALID_BAND_CONFIGURATION
	}

	decimal, validDecimal := valueOfColor[colors[0]]
	unit, validUnity := valueOfColor[colors[1]]

	if validDecimal || validUnity {
		return decimal*10 + unit
	}

	return INVALID_BAND_CONFIGURATION
}

// valueOfColor maps a resistor's band color to its numerical value.
var valueOfColor = map[string]int{
	"black":  0,
	"brown":  1,
	"red":    2,
	"orange": 3,
	"yellow": 4,
	"green":  5,
	"blue":   6,
	"violet": 7,
	"grey":   8,
	"white":  9,
}

// INVALID_BAND_CONFIGURATION value returned when the list of color ranges is not passed correctly.
const INVALID_BAND_CONFIGURATION int = -1
