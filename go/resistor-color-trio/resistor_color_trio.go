// Package resistorcolortrio provides functions to calculate and format the resistance value
// of a three-band resistor based on the color codes.
package resistorcolortrio

import (
	"fmt"
	"math"
)

// Label describes the resistance value given the colors of a resistor.
// The label is a string with a resistance value with an unit appended
// (e.g. "33 ohms", "470 kiloohms").
//
// The function takes a slice of strings (colors) where:
// - colors[0] is the first significant digit.
// - colors[1] is the second significant digit.
// - colors[2] is the multiplier (number of zeros).
func Label(colors []string) string {
	decimal := colorsValues[colors[0]]
	unity := colorsValues[colors[1]]
	zeros := colorsValues[colors[2]]

	value := (decimal*10 + unity) * intPow(10, zeros)

	return labeled(value)
}

// labeled converts the raw resistance value (in ohms) into a human-readable string
// with the appropriate metric prefix (kilo, mega, giga) and unit (ohms).
func labeled(value int) string {
	if value < 1_000 {
		return fmt.Sprintf("%d ohms", value)
	}
	if value < 1_000_000 {
		// Use integer division to drop the remainder
		return fmt.Sprintf("%d kiloohms", value/1_000)
	}
	if value < 1_000_000_000 {
		return fmt.Sprintf("%d megaohms", value/1_000_000)
	}
	return fmt.Sprintf("%d gigaohms", value/1_000_000_000)
}

// intPow calculates the integer power x^y.
func intPow(x, y int) int {
	fX := float64(x)
	fY := float64(y)

	return int(math.Pow(fX, fY))
}

// colorsValues maps standard resistor color names to their corresponding numeric values (0-9).
var colorsValues = map[string]int{
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
