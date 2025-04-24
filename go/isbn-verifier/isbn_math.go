package isbn

const (
	isbnDigitsCount = 10
	xDigitValue     = 10
)

// hasValidCheckSum returns whether or not the "clean" ISBN has a
// valid checksum. The checksum is considered valid if it is
// divisible by 11.
func hasValidCheckSum(isbn string) bool {
	return checkSum(isbn)%11 == 0
}

// checkSum returns the checksum of the given "clean" isbn.
// Calculates the checksum using the following formula
//
// (d₁ * 10 + d₂ * 9 + d₃ * 8 + d₄ * 7 + d₅ * 6 + d₆ * 5 + d₇ * 4 + d₈ * 3 + d₉ * 2 + d₁₀ * 1)
//
// Where dₙ is the nth digit.
func checkSum(isbn string) int {
	sum := 0
	weight := isbnDigitsCount

	for _, digit := range isbn {
		sum += isbnDigitValue(digit) * weight
		weight--
	}

	return sum
}

// isbnDigitValue Returns the numeric value of a given ISBN digit.
// Does not handle characters other than digits or X, their use in
// these scenarios generates undefined behavior.
func isbnDigitValue(digit rune) int {
	if digit == 'X' {
		return xDigitValue
	}

	return int(digit - '0')
}
