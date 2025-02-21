// Package prime provides functions for prime factorization.
package prime

import (
	"math"
)

// Factors returns the prime factors of a given number.
func Factors(n int64) []int64 {

	factors := []int64{}
	currentValue := n

	for prime := int64(2); prime <= int64Sqrt(n); prime = nextCandidate(prime) {
		for isDivisible(currentValue, prime) {
			factors = append(factors, prime)
			if currentValue == prime {
				return factors
			}
			currentValue /= prime
		}
	}

	if currentValue > 1 {
		factors = append(factors, currentValue)
	}

	return factors
}

// isDivisible checks if one number is divisible by another.
func isDivisible(dividend, divisor int64) bool {
	return dividend%divisor == 0
}

// nextCandidate returns the next candidate number for prime testing.
func nextCandidate(current int64) int64 {
	if current > 2 {
		return current + distanceBetweenTwoOdds
	}
	return current + distanceBetweenOddsAndEvens
}

// int64Sqrt returns the integer square root of a number.
func int64Sqrt(value int64) int64 {
	return int64(
		math.Sqrt(
			float64(value),
		),
	)
}

const distanceBetweenTwoOdds int64 = 2
const distanceBetweenOddsAndEvens int64 = 1
