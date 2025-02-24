// Package lsproduct provides a function to calculate the largest product of
// a series of digits in a string.
package lsproduct

import (
	"errors"
	"regexp"
)

// LargestSeriesProduct calculates the largest product of `span` consecutive
// digits in the given string.
func LargestSeriesProduct(digits string, span int) (int64, error) {
	const nullValue = 0

	if span < 0 {
		return 0, errors.New("slice bounds out of range")
	}

	if span > len(digits) {
		return nullValue, errors.New("span must be smaller than string length")
	}

	if regexp.MustCompile(`\D`).MatchString(digits) {
		return nullValue, errors.New("digits input must only contain digits")
	}

	parsedDigits := digitsOf(digits)
	limit := len(parsedDigits) - span
	largest := int64(0)

	for i := 0; i <= limit; i++ {
		largest = max(
			largest, serieProduct(parsedDigits[i:i+span]),
		)
	}

	return largest, nil
}

// digitsOf converts a string of digits into a slice of int8.
func digitsOf(num string) []int8 {
	digits := make([]int8, len(num))

	for i, digit := range num {
		digits[i] = int8(digit - '0')
	}

	return digits
}

// serieProduct calculates the product of all digits in the given slice.
func serieProduct(digits []int8) int64 {
	result := int64(1)

	for _, d := range digits {
		result *= int64(d)
	}

	return int64(result)
}

// max returns the larger of two int64 values.
func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}
