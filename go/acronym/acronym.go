// package acronym it is a module for creating acronyms. It provides a single
// function that is used to generate an acronym from an input text.
package acronym

import (
	"regexp"
	"strings"
)

// Abbreviate returns an acronym of the given string
func Abbreviate(s string) string {
	return strings.ToUpper(strings.Join(initialsOf(s), ""))
}

// words is a pattern of words in a sentence. Your capture group gets the
// initial of each word and the not group discards everything other than
// the initial.
var words = regexp.MustCompile(`([a-zA-Z])(?:[a-zA-Z\'])*`)

// initialsOf returns a slice containing all the initials of the words
// contained in the given string.
func initialsOf(s string) []string {
	initials := []string{}

	for _, match := range words.FindAllStringSubmatch(s, -1) {
		initials = append(initials, match[1])
	}

	return initials
}
