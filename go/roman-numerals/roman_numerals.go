package romannumerals

import "errors"

// MIN_ROMAN is the minimum valid integer for Roman numeral conversion.
const MIN_ROMAN = 1

// MAX_ROMAN is the maximum valid integer for Roman numeral conversion.
const MAX_ROMAN = 3999

// ToRomanNumeral converts an integer to its Roman numeral representation.
// It returns an error if the input is outside the valid range of 1 to 3999.
func ToRomanNumeral(input int) (string, error) {
	if input < MIN_ROMAN || input > MAX_ROMAN {
		return "", errors.New("input out of range")
	}

	number := ""

	for current := input; current > 0; {
		atom, value := nextAtom(current)
		current -= value
		number += atom
	}

	return number, nil
}

// nextAtom finds the largest Roman numeral atom that can be subtracted from a number.
// It returns the Roman numeral string and its integer value.
func nextAtom(number int) (string, int) {
	for _, value := range atomsValues {
		if number >= value {
			return atomsFromValue[value], value
		}
	}
	return "", 0
}

// atomsValues is a sorted slice of integer values for Roman numeral atoms.
var atomsValues = []int{
	1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1,
}

// atomsFromValue maps integer values to their corresponding Roman numeral strings.
var atomsFromValue = map[int]string{
	1000: "M",
	900:  "CM",
	500:  "D",
	400:  "CD",
	100:  "C",
	90:   "XC",
	50:   "L",
	40:   "XL",
	10:   "X",
	9:    "IX",
	5:    "V",
	4:    "IV",
	1:    "I",
}
