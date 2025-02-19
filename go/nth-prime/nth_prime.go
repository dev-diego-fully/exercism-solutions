// Package prime provides functions to work with prime numbers.
package prime

import (
	"errors"
	"math"
)

// Nth returns the nth prime number.
// Returns an error if n is less than 1.
func Nth(n int) (int, error) {
	if n < 1 {
		return 0, errors.New("invalid ordinality")
	}

	const distanceBetweenOdds = 2
	previousPrimes := []int{2}

	for candidate := 3; len(previousPrimes) < n; candidate += distanceBetweenOdds {
		if canBePrime(candidate, &previousPrimes) {
			previousPrimes = append(previousPrimes, candidate)
		}
	}

	return previousPrimes[n-1], nil
}

// canBePrime checks if a number is prime using previously found primes.
func canBePrime(value int, previousPrimes *[]int) bool {
	checkLimit := math.Ceil(math.Sqrt(float64(value)))

	for _, prime := range *previousPrimes {
		if float64(prime) > checkLimit {
			return true
		}
		if value%prime == 0 {
			return false
		}
	}

	return true
}
