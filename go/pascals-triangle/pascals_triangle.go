// Package pascal provides functions for generating Pascal's Triangle.
package pascal

// Triangle returns the first n rows of Pascal's Triangle.
// It generates a two-dimensional slice of integers, where each sub-slice represents a row.
func Triangle(n int) [][]int {
	triangle := make([][]int, 0, n)

	for i := 0; i < n; i++ {
		triangle = append(triangle, triangleLine(i))
	}

	return triangle
}

// triangleLine generates a single row of Pascal's Triangle based on the row index.
// It uses the binomial coefficient formula to calculate each value.
func triangleLine(r int) []int {
	row := make([]int, 0, r)

	for column := 0; column <= r; column++ {
		row = append(row, triangleValue(r, column))
	}

	return row
}

// triangleValue calculates the value at a specific row and column in Pascal's Triangle.
// It uses the formula nCr = n! / (r! * (n-r)!), where r is the row and c is the column.
func triangleValue(r, c int) int {
	fatRow := fatorial(r)
	fatPos := fatorial(c)
	fatDelta := fatorial(r - c)
	return fatRow / (fatPos * fatDelta)
}

// fatorial calculates the factorial of a non-negative integer n.
func fatorial(n int) int {
	if n == 0 {
		return 1
	}

	result := 1

	for i := 1; i <= n; i++ {
		result *= i
	}

	return result
}
