package diffsquares

// SquareOfSum calculate the square of the sum of the terms from
// 1 to n (with n as a natural number). This calculation is done using
// the mathematical formula.
func SquareOfSum(n int) int {
	sum := n * (1 + n) / 2
	return sum * sum
}

// SumOfSquares calculates the sum of the square of each term between
// 1 and n (expect n as natural). Use the formula for this calculation.
func SumOfSquares(n int) int {
	return n * (n + 1) * (2*n + 1) / 6
}

// Difference calculates the difference between the square of the sum
// of terms from 1 to n and the sum of the squares of terms from 1 to n.
// Expects natural n and uses mathematical formula for calculation.
func Difference(n int) int {
	return SquareOfSum(n) - SumOfSquares(n)
}
