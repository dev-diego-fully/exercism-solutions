package luhn

import (
	"regexp"
	"unicode"
)

// Returns whether a luhn code is valid or not.
func Valid(id string) bool {
	if containsInvalidRune(id) {
		return false
	}

	digits := onlyDigits(id)

	if isInvalidDigits(digits) {
		return false
	}

	sum := luhnSum(digits)

	return isValidLuhnSum(sum)
}

// Returns whether or not a string contains any runes that cannot be
// present in a luhn code.
func containsInvalidRune(id string) bool {
	return invalidRunePattern.MatchString(id)
}

// Returns whether or not a list of digits has a chance of being a valid
// Luhn code.
func isInvalidDigits(digits []int) bool {
	const luhnMininumDigits = 2

	return len(digits) < luhnMininumDigits
}

// Filters all non-digit characters from a string and converts the digits to
// their integer value. Returns the result as a slice of integers.
func onlyDigits(id string) []int {
	digits := []int{}

	for _, character := range id {
		if unicode.IsDigit(character) {
			digits = append(digits, int(character-'0'))
		}
	}

	return digits
}

// Calculates a sum of digits used to check if a Luhn code is valid or not.
// Performs the number doubling used in Luhn every 2 digits backwards
// (starting from the second digit).
func luhnSum(digits []int) int {
	sum := 0
	digitsCount := len(digits)
	reversedPairIndexRem := digitsCount % 2

	for index := digitsCount - 1; index >= 0; index-- {
		if index%2 == reversedPairIndexRem {
			sum += doubleDigit(digits[index])
		} else {
			sum += digits[index]
		}
	}

	return sum
}

// Checks if a given "row sum" is valid. It is considered valid if it
// is a multiple of 10.
func isValidLuhnSum(sum int) bool {
	return sum%10 == 0
}

// Pattern used to check whether or not a string contains invalid characters
// for a Luhn code.
var invalidRunePattern = regexp.MustCompile(`[^\s\d]`)

// Digit doubling operation used to calculate the Luhn sum. If double the
// digit is greater than 9, subtract 9 from the value. Otherwise, return
// only double the given digit.
func doubleDigit(digit int) int {
	doubled := digit * 2

	if doubled > 9 {
		doubled = doubled - 9
	}

	return doubled
}
