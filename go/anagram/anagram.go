package anagram

import (
	"sort"
	"strings"
)

// Detect returns a slice of candidates that are anagrams of the given subject.
func Detect(subject string, candidates []string) []string {
	loweredSubject := strings.ToLower(subject)
	comparableSubject := sortedString(loweredSubject)

	var anagrams []string = []string{}
	for _, candidate := range candidates {
		loweredCandidate := strings.ToLower(candidate)
		comparableCandidate := sortedString(loweredCandidate)

		if loweredCandidate != loweredSubject && comparableCandidate == comparableSubject {
			anagrams = append(anagrams, candidate)
		}
	}

	return anagrams
}

// sortedString returns a string with its runes sorted by Unicode values.
func sortedString(input string) string {
	runes := []rune(input)

	sort.Slice(runes, func(i, j int) bool {
		return runes[i] < runes[j]
	})

	return string(runes)
}
