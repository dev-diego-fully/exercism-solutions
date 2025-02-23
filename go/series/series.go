// Package series provides functions to extract contiguous substrings of
// a specified length from a string.
// It is designed to solve the problem of generating all possible substrings of length n from a given string of digits,
// preserving the order in which they appear.
//
// For example, given the string "49142":
// - 3-digit series: "491", "914", "142"
// - 4-digit series: "4914", "9142"
package series

// All returns all possible contiguous substrings of length n from the
// string s.
func All(n int, s string) []string {
	series := []string{}

	limit := len(s) - n

	for currentStart := 0; currentStart <= limit; currentStart++ {
		series = append(series, s[currentStart:currentStart+n])
	}

	return series
}

// UnsafeFirst returns the first substring of length n from the string s
// without checking bounds.
func UnsafeFirst(n int, s string) string {
	return All(n, s)[0]
}

// First returns the first substring of length n from the string s and
// a boolean indicating success.
func First(n int, s string) (string, bool) {
	if n <= len(s) {
		return All(n, s)[0], true
	}
	return "", false
}
