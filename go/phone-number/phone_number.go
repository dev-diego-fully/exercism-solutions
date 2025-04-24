// phonenumber provides functions for handling phone numbers in any format,
// allowing you to extract the "clean" phone number, get the area code from
// a number, and change the format of a number to (xxx) xxx-xxxx
package phonenumber

// Number for a given phone number in any format, returns only the raw phone
// number. Ignoring any country code or valid character. If the number is
// invalid, returns an error.
func Number(phoneNumber string) (string, error) {
	phone, err := phoneFrom(phoneNumber)

	if err != nil {
		return "", err
	}

	return phone.number(), nil
}

// AreaCode for a given input phone, returns the area code of that phone,
// if it is valid. If invalid, returns an error.
func AreaCode(phoneNumber string) (string, error) {
	phone, err := phoneFrom(phoneNumber)

	if err != nil {
		return "", err
	}

	return phone.areaCode(), nil
}

// Format for a given input phone number, in any format, returns the phone
// number in the format: (xxx) xxx-xxxx if the phone number is valid. If the
// phone number is invalid, returns an error.
func Format(phoneNumber string) (string, error) {
	phone, err := phoneFrom(phoneNumber)

	if err != nil {
		return "", err
	}

	return phone.format(), nil
}
