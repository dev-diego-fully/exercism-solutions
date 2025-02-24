// Package sieve implements the Sieve of Eratosthenes to generate prime numbers.
package sieve

// Sieve returns all prime numbers up to the given limit.
func Sieve(limit int) []int {
	if limit < firstPrime {
		return nil
	}

	candidatesStatus := make([]bool, limit-firstPrime+1)

	for index, rejected := range candidatesStatus {
		if !rejected {
			rejectMultiplies(
				&candidatesStatus, candidateFromIndex(index),
			)
		}
	}

	primes := []int{}
	for num, rejected := range candidatesStatus {
		if !rejected {
			primes = append(primes, candidateFromIndex(num))
		}
	}

	return primes
}

// rejectMultiplies marks multiples of the given divisor as non-prime
// in the sieve.
func rejectMultiplies(status *[]bool, divisor int) {
	first := indexOfCandidate(divisor * divisor)

	for i := first; i < len(*status); i += divisor {
		(*status)[i] = true
	}
}

// indexOfCandidate returns the index of a number in the sieve array.
func indexOfCandidate(value int) int {
	return value - firstPrime
}

// candidateFromIndex returns the number corresponding to the
// given index in the sieve array.
func candidateFromIndex(index int) int {
	return firstPrime + index
}

const firstPrime = 2
