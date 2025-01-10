// Package summultiples provides utilities to calculate the sum of multiples within a range.
package summultiples

// SumMultiples returns the sum of all numbers in the range (1, limit]
// that are divisible by at least one of the provided divisors.
func SumMultiples(limit int, divisors ...int) int {
	return sum(
		filterMultiples(
			multiplesCandidates(limit),
			divisors,
		),
	)
}

// multiplesCandidates generates a slice of integers in the range (1, limit].
func multiplesCandidates(limit int) []int {
	canditates := make([]int, limit-1)

	for i := 1; i < limit; i++ {
		canditates[i-1] = i
	}

	return canditates
}

// filterMultiples filters values, keeping only those divisible by at
// least one of the provided divisors.
func filterMultiples(values, divisors []int) []int {
	divisibles := []int{}

	for _, value := range values {
		if hasDivisorIn(value, divisors) {
			divisibles = append(divisibles, value)
		}
	}

	return divisibles
}

// sum calculates and returns the sum of all elements in the given slice.
func sum(numbers []int) int {
	sum := 0

	for _, number := range numbers {
		sum += number
	}

	return sum
}

// hasDivisorIn checks if the given value is divisible by any number in
// the divisors slice.
func hasDivisorIn(value int, divisors []int) bool {
	for _, divisor := range divisors {
		if isDivisible(value, divisor) {
			return true
		}
	}

	return false
}

// isDivisible checks if value is divisible by divisor. Returns false
// if divisor is zero to avoid division by zero.
func isDivisible(value, divisor int) bool {
	return divisor != 0 && value%divisor == 0
}
