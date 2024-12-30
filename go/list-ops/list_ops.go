package listops

// IntList represents a list of integers.
type IntList []int

// Foldl applies a function to each element of the list from left to right, starting with an initial value.
func (s IntList) Foldl(fn func(int, int) int, initial int) int {
	result := initial

	for _, v := range s {
		result = fn(result, v)
	}

	return result
}

// Foldr applies a function to each element of the list from right to left, starting with an initial value.
func (s IntList) Foldr(fn func(int, int) int, initial int) int {
	result := initial
	maxIndex := s.Length() - 1

	for i := range s {
		result = fn(s[maxIndex-i], result)
	}

	return result
}

// Filter returns a new list containing only the elements that satisfy the given predicate.
func (s IntList) Filter(fn func(int) bool) IntList {
	var result IntList = IntList{}

	for _, v := range s {
		if fn(v) {
			result = append(result, v)
		}
	}

	return result
}

// Length returns the number of elements in the list.
func (s IntList) Length() int {
	return len(s)
}

// Map applies a function to each element of the list and returns a new list with the results.
func (s IntList) Map(fn func(int) int) IntList {
	result := make(IntList, s.Length())

	for i, v := range s {
		result[i] = fn(v)
	}

	return result
}

// Reverse returns a new list with the elements in reverse order.
func (s IntList) Reverse() IntList {
	result := make(IntList, s.Length())

	lastIndex := s.Length() - 1
	for i, v := range s {
		result[lastIndex-i] = v
	}

	return result
}

// Append adds the elements of another list to the end of the current list.
func (s IntList) Append(lst IntList) IntList {
	result := make(IntList, s.Length())
	copy(result, s)

	return append(result, lst...)
}

// Concat combines the current list with multiple other lists into a single list.
func (s IntList) Concat(lists []IntList) IntList {
	result := make(IntList, s.Length())
	copy(result, s)

	for _, v := range lists {
		result = result.Append(v)
	}

	return result
}
