// Package binarysearch provides functions for performing binary search on sorted data.
package binarysearch

// SearchInts searches for an integer key in a sorted slice of integers.
// It returns the index of the key if found, or -1 if the key is not present.
// The provided slice must be sorted in ascending order for the search to work correctly.
func SearchInts(list []int, key int) int {
	for bot, top := 0, len(list)-1; bot <= top; {
		middle := (bot + top) / 2
		candidate := list[middle]

		if candidate == key {
			return middle
		}

		if candidate > key {
			top = middle - 1
		} else {
			bot = middle + 1
		}
	}
	return -1
}
