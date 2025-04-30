package wordcount

import (
	"regexp"
	"strings"
)

// Frequency is a type of counting the number of times a word was found
// in a text.
type Frequency map[string]int

// WordCount returns a count of the number of times each word in the given
// phrase appears in the text.
func WordCount(phrase string) Frequency {
	frequencies := make(Frequency)

	for _, word := range wordsOf(phrase) {
		frequencies[strings.ToLower(word)] += 1
	}

	return frequencies
}

// wordsPattern is the pattern of what is considered a word by the wordsOf
// function
var wordsPattern = regexp.MustCompile(`\b[a-zA-Z\d][a-zA-z\d\']*\b`)

// wordsOf returns all possible words found in the given text. If none are
// found, an empty slice is returned. The words are returned in the order
// they were found and may be repeated.
func wordsOf(phrase string) []string {
	words := wordsPattern.FindAllString(phrase, -1)

	if words == nil {
		return []string{}
	}
	return words
}
