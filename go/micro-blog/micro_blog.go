// Package microblog provides utilities for handling short blog post text formatting.
package microblog

// TEXT_SIZE defines the maximum number of unicode characters (runes) allowed before truncation.
const TEXT_SIZE = 5

// Truncate shortens a given string to a maximum length of TEXT_SIZE characters (runes).
// If the input string contains fewer characters than TEXT_SIZE, it returns the original string.
func Truncate(phrase string) string {
	runes := []rune(phrase)
	length := len(runes)

	if length >= 5 {
		return string(runes[0:TEXT_SIZE])
	}

	return string(runes[0:length])
}
