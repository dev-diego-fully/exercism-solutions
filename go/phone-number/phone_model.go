package phonenumber

import "fmt"

// phone represents a telephone number, with its digit groups separated into
// their own attributes.
type phone struct {
	planAreaCode    string
	exchangeCode    string
	subscribeNumber string
}

// number returns the full number of a phone.
func (p phone) number() string {
	return p.planAreaCode + p.exchangeCode + p.subscribeNumber
}

// format returns the phone number formatted in the format (xxx) xxx-xxxx
func (p phone) format() string {
	return fmt.Sprintf(
		outputPhoneFormat,
		p.planAreaCode, p.exchangeCode, p.subscribeNumber)
}

// areaCode returns the phone's area code.
func (p phone) areaCode() string {
	return p.planAreaCode
}

// phoneFrom creates a new phone instance from a phone number in any format.
// If the format is invalid or if the number format is invalid the creation
// fails, returning an error.
func phoneFrom(phoneNumber string) (phone, error) {

	has, found := hasInvalidRuneForPhoneNumber(phoneNumber)

	if has {
		return phone{}, errFindInvalidRune(found)
	}

	cleaned := cleanPhoneNumber(phoneNumber)

	match := inputPhonePattern.FindStringSubmatch(cleaned)

	if match == nil {
		return phone{}, errInvalidPhoneNumber(cleaned)
	}

	return phone{
		planAreaCode:    match[1],
		exchangeCode:    match[2],
		subscribeNumber: match[3],
	}, nil

}
