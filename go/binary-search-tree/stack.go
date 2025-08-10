package binarysearchtree

// push adds a value to the end of a slice.
func push[T any](slice *[]T, value T) {
	(*slice) = append(*slice, value)
}

// pop removes and returns the last element from a slice.
// It returns a boolean indicating whether an element was present.
func pop[T any](slice *[]T) (T, bool) {
	if isEmpty(slice) {
		var zero T
		return zero, false
	}
	popIndex := len(*slice) - 1
	popped := (*slice)[popIndex]
	(*slice) = (*slice)[:popIndex]
	return popped, true
}

// isEmpty returns true if the slice contains no elements.
func isEmpty[T any](slice *[]T) bool {
	return len(*slice) == 0
}
