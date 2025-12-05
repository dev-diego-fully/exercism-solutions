// Package allyourbase provides functions for converting numbers between arbitrary bases.
package allyourbase

import (
	"errors"
	"math"
)

// ConvertToBase converts a number represented by `inputDigits` in the `inputBase`
// to a new representation in the `outputBase`.
//
// It returns a slice of integers with the digits in the new base or an error if
// the bases are invalid or if input digits are outside the valid range.
func ConvertToBase(inputBase int, inputDigits []int, outputBase int) ([]int, error) {
	if inputBase < 2 {
		return conversionFail("input base must be >= 2")
	}
	if outputBase < 2 {
		return conversionFail("output base must be >= 2")
	}
	if !validateNumber(inputDigits, inputBase) {
		return conversionFail("all digits must satisfy 0 <= d < input base")
	}
	if len(inputDigits) == 0 {
		return conversionSuccess([]int{0})
	}

	numberValue := desconvertFromBase(inputDigits, inputBase)
	resultValue := convertToBase(numberValue, outputBase)

	return conversionSuccess(resultValue)
}

// validateNumber checks if all digits in the slice are within the valid range
// for the given base (0 <= d < base).
func validateNumber(digits []int, base int) bool {
	for _, digit := range digits {
		if digit < 0 || digit >= base {
			return false
		}
	}

	return true
}

// desconvertFromBase calculates the numerical magnitude of the number represented
// by the input digits in an arbitrary base.
//
// It returns this magnitude as a standard Go integer value.
func desconvertFromBase(digits []int, base int) int {
	totalDigits := len(digits)
	value := 0

	for index, digit := range digits {
		position := totalDigits - index - 1
		value += valueOfDigit(digit, position, base)
	}

	return value
}

// convertToBase converts an integer value into a slice of digits
// representing that number in the target arbitrary base.
//
// It uses the method of successive division.
func convertToBase(value, base int) []int {
	if value == 0 {
		return []int{0}
	}

	currentDigits := []int{}

	for currentValue := value; currentValue > 0; currentValue /= base {
		digit := currentValue % base
		currentDigits = append(currentDigits, digit)
	}

	return reverseSlice(currentDigits)
}

// valueOfDigit calculates the weighted value of a single digit based on its position and base.
func valueOfDigit(digit, position, base int) int {
	return digit * intPow(base, position)
}

// conversionFail is a utility function to return a failure result with an empty
// slice and a formatted error.
func conversionFail(message string) ([]int, error) {
	return []int{}, errors.New(message)
}

// conversionSuccess is a utility function to return a successful result with the
// converted value and a nil error.
func conversionSuccess(value []int) ([]int, error) {
	return value, nil
}

// intPow calculates the integer power x^y.
func intPow(x, y int) int {
	fX := float64(x)
	fY := float64(y)

	return int(math.Pow(fX, fY))
}

// reverseSlice reverses the order of elements in an integer slice.
func reverseSlice(source []int) []int {
	size := len(source)
	reversed := make([]int, size)

	for index, value := range source {
		revIndex := size - index - 1
		reversed[revIndex] = value
	}

	return reversed
}
