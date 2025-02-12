// Package resistorcolor provides utilities to work with resistor color codes.
// It includes functions to retrieve the list of valid resistor colors and
// to determine the resistance value associated with a specific color.
// This package is useful for applications involving electronics, circuit design,
// or educational tools related to resistors.
package resistorcolor

// INVALID_COLOR_CODE represents that the color code value was not found
const INVALID_COLOR_CODE = -1

var colors = []string{
	"black", "brown", "red", "orange", "yellow",
	"green", "blue", "violet", "grey", "white",
}

// Colors returns the list of all colors.
func Colors() []string {
	result := make([]string, len(colors))
	copy(result, colors)
	return result
}

// ColorCode returns the resistance value of the given color.
func ColorCode(color string) int {
	for i, c := range colors {
		if c == color {
			return i
		}
	}
	return INVALID_COLOR_CODE
}
