// Package squareroot provides functionality for calculating integer square roots.
package squareroot

import "errors"

// SquareRoot calculates the integer square root of a given non-negative integer using linear search.
// It returns the exact integer root, or an error if no exact root exists or if the number is negative.
func SquareRoot(number int) (int, error) {
	for candidate := 0; true; candidate++ {
		square := candidate * candidate

		if square == number {
			return candidate, nil
		}
		if square > number {
			break
		}
	}

	return 0, errors.New("Cannot calculate the square root of non-positive numbers.")
}
