package isogram

import (
	"unicode"
)

// IsIsogram checks if a given string does not have repeated letters
// (it is an isogram).
func IsIsogram(word string) bool {
	lettersFound := make(map[rune]bool)

	for _, current := range word {
		if !unicode.IsLetter(current) {
			continue
		}
		lowered := unicode.ToLower(current)
		if lettersFound[lowered] {
			return false
		}
		lettersFound[lowered] = true
	}

	return true
}
