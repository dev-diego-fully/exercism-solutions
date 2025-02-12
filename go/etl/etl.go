// Package etl provides utilities for transforming data formats.
// It includes functionality to convert score-based letter groupings
// into a normalized map for efficient lookups.
package etl

import "strings"

// Transform converts a map of scores to letters into a map of letters
// to scores. It normalizes letters to lowercase to ensure
// case-insensitive lookups.
func Transform(in map[int][]string) map[string]int {
	out := map[string]int{}

	for score, letters := range in {
		for _, letter := range letters {
			out[strings.ToLower(letter)] = score
		}
	}

	return out
}
