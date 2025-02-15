// Package rotationalcipher implements a simple rotational cipher (Caesar cipher).
package rotationalcipher

import "unicode"

// LetterCase represents the case of a letter (uppercase, lowercase, or no case).
type LetterCase int

const (
	LetterCaseNoCase LetterCase = iota // Letter has no case (e.g., not a letter).
	LetterCaseUpper                    // Letter is uppercase.
	LetterCaseLower                    // Letter is lowercase.
)

// letterFromIndex returns the letter corresponding to the given index and case.
func letterFromIndex(index int, letterCase LetterCase) rune {
	switch letterCase {
	case LetterCaseUpper:
		return rune(int('A') + index)

	case LetterCaseLower:
		return rune(int('a') + index)

	default:
		return invalidLetterIndex
	}
}

// indexFromLetter returns the index of a letter in the alphabet (0-25).
func indexFromLetter(letter rune) int {
	if unicode.IsLower(letter) {
		return int(letter - 'a')
	}

	if unicode.IsUpper(letter) {
		return int(letter - 'A')
	}

	return invalidLetterIndex
}

// letterCase returns the case of a letter (uppercase, lowercase, or no case).
func letterCase(letter rune) LetterCase {
	if unicode.IsLower(letter) {
		return LetterCaseLower
	}

	if unicode.IsUpper(letter) {
		return LetterCaseUpper
	}

	return LetterCaseNoCase
}

// invalidLetterIndex represents an invalid letter index.
const invalidLetterIndex = -1
