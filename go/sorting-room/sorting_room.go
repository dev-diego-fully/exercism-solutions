package sorting

import (
	"fmt"
	"strconv"
)

// DescribeNumber should return a string describing the number.
func DescribeNumber(f float64) string {
	const descriptionTemplate string = "This is the number %.1f"

	return fmt.Sprintf(descriptionTemplate, f)
}

type NumberBox interface {
	Number() int
}

// DescribeNumberBox should return a string describing the NumberBox.
func DescribeNumberBox(nb NumberBox) string {
	const descriptionTemplate string = "This is a box containing the number %.1f"

	return fmt.Sprintf(descriptionTemplate, float64(nb.Number()))
}

type FancyNumber struct {
	n string
}

func (i FancyNumber) Value() string {
	return i.n
}

type FancyNumberBox interface {
	Value() string
}

// ExtractFancyNumber should return the integer value for a FancyNumber
// and 0 if any other FancyNumberBox is supplied.
func ExtractFancyNumber(fnb FancyNumberBox) int {
	const errorExit = 0

	fancyNumber, ok := fnb.(FancyNumber)
	if !ok {
		return errorExit
	}

	value, err := strconv.Atoi(fancyNumber.Value())
	if err != nil {
		return errorExit
	}

	return value

}

// DescribeFancyNumberBox should return a string describing the FancyNumberBox.
func DescribeFancyNumberBox(fnb FancyNumberBox) string {
	const descriptionTemplate string = "This is a fancy box containing the number %.1f"

	return fmt.Sprintf(descriptionTemplate, float64(ExtractFancyNumber(fnb)))
}

// DescribeAnything should return a string describing whatever it contains.
func DescribeAnything(i interface{}) string {

	const noMatchMessage string = "Return to sender"

	if value, isInt := i.(int); isInt {
		return DescribeNumber(float64(value))
	}
	if value, isFloat := i.(float64); isFloat {
		return DescribeNumber(value)
	}
	if value, isNumberBox := i.(NumberBox); isNumberBox {
		return DescribeNumberBox(value)
	}
	if value, isFancyNumberBox := i.(FancyNumberBox); isFancyNumberBox {
		return DescribeFancyNumberBox(value)
	}

	return noMatchMessage
}
