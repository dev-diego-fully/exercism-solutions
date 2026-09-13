// Package eliudseggs provides functionality to count eggs from display values.
package eliudseggs

// EggCount returns the number of eggs by counting the set bits (1s) in the binary representation of displayValue.
func EggCount(displayValue int) int {
	remmaingValue := displayValue
	eggsCount := 0

	for remmaingValue > 0 {
		eggsCount += remmaingValue % 2
		remmaingValue /= 2
	}

	return eggsCount
}
