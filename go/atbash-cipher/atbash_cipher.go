// Package atbash implements the Atbash cipher, a simple substitution cipher
// that maps each letter of the alphabet to its reverse.
package atbash

import (
	"math"
	"regexp"
	"strings"
	"unicode"
)

// Atbash encrypts a string using the Atbash cipher.
func Atbash(s string) string {
	return strings.Map(encryptLetter, normalize(s))
}

// encryptLetter encrypts a single letter using the Atbash cipher.
func encryptLetter(letter rune) rune {
	if !unicode.IsLetter(letter) {
		return letter
	}

	var letterCase = caseOfLetter(letter)
	var letterIndex = indexOfLetter(letter, letterCase)

	return letterFrom(
		invertLetterIndex(letterIndex),
		letterCase,
	)
}

// indexOfLetter returns the index of a letter in the alphabet (0-25).
func indexOfLetter(letter, letterCase rune) int {
	return int(letter - letterCase)
}

// caseOfLetter returns the base rune ('A' or 'a') for the letter's case.
func caseOfLetter(letter rune) rune {
	if unicode.IsUpper(letter) {
		return 'A'
	}
	return 'a'
}

// letterFrom returns the letter corresponding to the given index and case.
func letterFrom(index int, letterCase rune) rune {
	return letterCase + rune(index)
}

// invertLetterIndex inverts the letter index for the Atbash cipher.
func invertLetterIndex(index int) int {
	const alphabetLength = 26

	return alphabetLength - (index + 1)
}

// normalize cleans and formats the input string for encryption.
func normalize(s string) string {
	var trashPattern = `\W`
	var separatedPattern = `\S{0,5}`

	cleaned := regexp.
		MustCompile(trashPattern).
		ReplaceAllString(s, "")
	lowered := strings.ToLower(cleaned)

	return strings.Join(
		regexp.
			MustCompile(separatedPattern).
			FindAllString(lowered, math.MaxInt64),
		" ",
	)
}
