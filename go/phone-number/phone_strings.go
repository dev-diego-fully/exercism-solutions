package phonenumber

import "regexp"

const outputPhoneFormat = "(%s) %s-%s"

var (
	phoneIgnorableRunes = regexp.MustCompile(`\D`)
	phoneInvalidRunes   = regexp.MustCompile(`[^\+\d\s\.\-\(\)]`)
	inputPhonePattern   = regexp.MustCompile(`^1?([2-9]\d{2})([2-9]\d{2})(\d{4})$`)
)

// cleanPhoneNumber removes all valid characters that are in the phone, but
// are useless for analyzing the phone number (all non-digit characters).
func cleanPhoneNumber(phoneNumber string) string {
	return phoneIgnorableRunes.ReplaceAllString(phoneNumber, "")
}

// hasInvalidRuneForPhoneNumber returns whether or not the given string
// contains runes that cannot be present in a phone number (regardless
// of format). Also returns the found rune (as a string).
func hasInvalidRuneForPhoneNumber(phoneNumber string) (bool, string) {
	found := phoneInvalidRunes.FindStringSubmatch(phoneNumber)

	if found == nil {
		return false, ""
	}

	return true, found[0]
}
