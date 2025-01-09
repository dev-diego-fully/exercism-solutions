package perfect

import "errors"

// Classify determines the classification of a number based on the sum of
// its factors. Returns an error if the input number is not positive.
func Classify(n int64) (Classification, error) {
	if n <= 0 {
		return ClassificationInvalid, ErrOnlyPositive
	}

	factorsSum := sum(factors(n))

	if factorsSum < n {
		return ClassificationDeficient, nil
	}
	if factorsSum == n {
		return ClassificationPerfect, nil
	}
	return ClassificationAbundant, nil
}

// Classification represents the classification of a number based on the
// sum of its proper factors.
type Classification int

const (
	// ClassificationInvalid represents an invalid classification
	// (used for errors).
	ClassificationInvalid Classification = iota - 1
	// ClassificationDeficient indicates the sum of factors is less than the number.
	ClassificationDeficient
	// ClassificationPerfect indicates the sum of factors is equal to the number.
	ClassificationPerfect
	// ClassificationAbundant indicates the sum of factors is greater than the number.
	ClassificationAbundant
)

// ErrOnlyPositive is returned when a non-positive number is provided
// to Classify.
var ErrOnlyPositive = errors.New("only positive number allowed")

// factors returns the factors of a number in the range (1, n).
func factors(n int64) []int64 {
	factors := []int64{}

	for i := int64(1); i < n; i++ {
		if n%i == 0 {
			factors = append(factors, i)
		}
	}

	return factors
}

// sum returns the sum of all integers in the given slice.
func sum(numbers []int64) int64 {
	sum := int64(0)

	for _, num := range numbers {
		sum += num
	}

	return sum
}
