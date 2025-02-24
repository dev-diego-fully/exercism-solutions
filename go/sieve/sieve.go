// Package sieve provides functions to generate prime numbers using the Sieve of Eratosthenes.
package sieve

// Sieve returns a list of prime numbers up to the given limit.
func Sieve(limit int) []int {
	if limit < firstPrime {
		return nil
	}

	candidatesStatus := make([]bool, limit-firstPrime+1)

	for index, rejected := range candidatesStatus {
		if !rejected {
			candidatesStatus = rejectMultiplies(
				candidatesStatus, candidateFromIndex(index),
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

// rejectMultiplies marks multiples of the given divisor as non-prime.
func rejectMultiplies(status []bool, divisor int) []bool {
	first := indexOfCandidate(divisor * divisor)

	for i := first; i < len(status); i += divisor {
		status[i] = true
	}

	return status
}

// indexOfCandidate returns the index of a candidate number in the sieve.
func indexOfCandidate(value int) int {
	return value - firstPrime
}

// candidateFromIndex returns the number corresponding to a given index in the sieve.
func candidateFromIndex(index int) int {
	return firstPrime + index
}

const firstPrime = 2
