package logs

import (
	"strings"
	"unicode/utf8"
)

func minInt(a, b int) int {
	if a < b {
		return a
	}

	return b
}

func minIndex(a, b int) int {
	if a <= -1 {
		return b
	}

	if b <= -1 {
		return a
	}

	return minInt(a, b)
}

// Application identifies the application emitting the given log.
func Application(log string) string {

	const recommendationRune rune = '❗'
	const searchRune rune = '🔍'
	const weatherRune rune = '☀'

	for _, curRune := range log {
		switch curRune {
		case recommendationRune:
			return "recommendation"
		case searchRune:
			return "search"
		case weatherRune:
			return "weather"
		}
	}
	return "default"

}

// Replace replaces all occurrences of old with new, returning the modified log
// to the caller.
func Replace(log string, oldRune, newRune rune) string {
	return strings.ReplaceAll(log, string(oldRune), string(newRune))
}

// WithinLimit determines whether or not the number of characters in log is
// within the limit.
func WithinLimit(log string, limit int) bool {
	return utf8.RuneCountInString(log) <= limit
}
