package pangram

import "unicode"

// IsPangram Checks if the string uses all letters of the alphabet (is a pangram).
func IsPangram(input string) bool {
	seenLetters := make(letterTracker)

	for _, current := range input {
		if seenLetters.trackLetter(current) >= 26 {
			return true
		}
	}

	return false
}

type letterTracker map[rune]bool

// trackLetter Marks the character as already found if it is a letter.
// Returns the number of letters found so far (including
// the letter added in the current call).
func (ls letterTracker) trackLetter(letter rune) int {
	lowered := unicode.ToLower(letter)

	if unicode.IsLetter(letter) && !ls[lowered] {
		ls[lowered] = true
	}

	return len(ls)
}
