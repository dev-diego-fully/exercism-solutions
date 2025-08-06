// Package strain provides generic functions to keep or discard elements
// from a slice based on a given predicate function.
package strain

// Discard returns a new slice containing all elements for which the
// discardCondition predicate is false.
func Discard[T any](list []T, discardCondition predicate[T]) []T {
	result := []T{}

	for _, value := range list {
		if !discardCondition(value) {
			result = append(result, value)
		}
	}

	return result
}

// Keep returns a new slice containing all elements for which the
// keepCondition predicate is true.
func Keep[T any](list []T, keepCondition predicate[T]) []T {
	result := []T{}

	for _, value := range list {
		if keepCondition(value) {
			result = append(result, value)
		}
	}

	return result
}

// predicate is a function that takes a value of type T and returns a boolean.
type predicate[T any] func(value T) bool
