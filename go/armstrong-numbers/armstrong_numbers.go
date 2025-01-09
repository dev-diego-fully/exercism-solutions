// Package armstrong provides utilities to check if a number is an Armstrong number.
package armstrong

import (
	"math"
	"strconv"
)

// IsNumber checks if a given number is an Armstrong number.
// An Armstrong number is a number that is equal to the sum of its digits,
// each raised to the power of the number of digits.
func IsNumber(n int) bool {
	return armstrongSum(n) == n
}

// armstrongSum calculates the Armstrong sum of a number.
// The Armstrong sum is the sum of each digit of the number raised to the
// power of the total number of digits.
func armstrongSum(n int) int {
	digitsOfN := digits(n)
	digitsCount := len(digitsOfN)

	sum := 0
	for _, digit := range digitsOfN {
		sum += digitPow(digit, digitsCount)
	}

	return sum
}

// digits extracts the digits of a number and returns them as a slice of integers.
func digits(n int) []int8 {
	strNum := strconv.Itoa(n)
	digitsCount := len(strNum)
	digs := make([]int8, digitsCount)

	for i := 0; i < digitsCount; i++ {
		digs[i] = int8(strNum[i] - '0')
	}

	return digs
}

// digitPow raises a single digit to the specified power and returns the result.
func digitPow(digit int8, power int) int {
	return int(
		math.Pow(
			float64(digit),
			float64(power),
		),
	)
}
