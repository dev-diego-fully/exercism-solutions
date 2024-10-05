package thefarm

import (
	"errors"
	"fmt"
)

func DivideFood(fodder FodderCalculator, cowsNumber int) (float64, error) {
	factor, factorErr := fodder.FatteningFactor()
	amount, amountErr := fodder.FodderAmount(cowsNumber)

	if amountErr != nil {
		return 0, amountErr
	}
	if factorErr != nil {
		return 0, factorErr
	}
	return (amount * factor) / float64(cowsNumber), nil
}

func ValidateInputAndDivideFood(fodder FodderCalculator, cowsNumber int) (float64, error) {
	if cowsNumber > 0 {
		return DivideFood(fodder, cowsNumber)
	}

	return 0, errors.New("invalid number of cows")
}

type InvalidCowsError struct {
	cowsNumber    int
	customMessage string
}

func (invCowsErr *InvalidCowsError) Error() string {
	const errorTemplate string = "%d cows are invalid: %s"

	return fmt.Sprintf(
		errorTemplate, invCowsErr.cowsNumber, invCowsErr.customMessage,
	)
}

func NewInvalidCowsError(numberOfCows int, customMessage string) *InvalidCowsError {
	return &InvalidCowsError{
		cowsNumber:    numberOfCows,
		customMessage: customMessage,
	}
}

func ValidateNumberOfCows(numberOfCows int) *InvalidCowsError {
	if numberOfCows < 0 {
		return NewInvalidCowsError(numberOfCows, "there are no negative cows")
	}

	if numberOfCows == 0 {
		return NewInvalidCowsError(numberOfCows, "no cows don't need food")
	}

	return nil
}
