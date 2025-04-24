package phonenumber

import (
	"fmt"
)

var (
	invalidRuneFoundMessage = "invalid rune \"%s\" for a phone was found in the string"
	invalidPhoneMessage     = "phone number \"%s\" does not match the expected pattern"
)

// errFindInvalidRune returns an error when an invalid rune was found in the
// phone number. Indicates which rune was found in the message.
func errFindInvalidRune(found string) error {
	return fmt.Errorf(invalidRuneFoundMessage, found)
}

// errInvalidPhoneNumber returns an error when a given phone number is invalid.
// You should receive the "clean" phone number to indicate it in the error message.
func errInvalidPhoneNumber(number string) error {
	return fmt.Errorf(invalidPhoneMessage, number)
}
