package isbn

import "regexp"

// patterns
var (
	patternInvalidRune        = regexp.MustCompile(`[^\dX\s\-]`)
	patternPureIsbn           = regexp.MustCompile(`^\d{9}[\dX]$`)
	patternIgnorableISBNRunes = regexp.MustCompile(`[^\dX]`)
)

// hasInvalidISBNRune returns whether the given string contains a rune
// that is not acceptable in isbn for common formats.
func hasInvalidISBNRune(s string) bool {
	return patternInvalidRune.MatchString(s)
}

// cleanISBN removes from the given string all runes that are not useful
// for analyzing whether the ISBN code is valid.
func cleanISBN(isbn string) string {
	return patternIgnorableISBNRunes.ReplaceAllString(isbn, "")
}

// hasISBNFormat returns whether the date string has a valid format of an
// isbn with only numbers.
// Format: ddddddddddv; where d is digits and v is digits or X
func hasISBNFormat(s string) bool {
	return patternPureIsbn.MatchString(s)
}
