package grains

import (
	"errors"
)

// Square returns the number of grains on the specified square of the chessboard.
// The number must be between 1 and 64 (inclusive). If the number is out of range,
// an error is returned.
func Square(number int) (uint64, error) {
	if number < minSquare || number > maxSquare {
		return 0, errors.New("number must be between 1 and 64, inclusive")
	}
	return pow2(number - 1), nil
}

// Total calculates the total number of grains on the chessboard,
// from the first square to the last one (square 64).
func Total() uint64 {
	return pow2(maxSquare) - 1
}

// pow2 calculates 2 raised to the power of the given number.
func pow2(number int) uint64 {
	return uint64(1 << number)
}

const minSquare, maxSquare = 1, 64
