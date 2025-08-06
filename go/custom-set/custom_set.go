// Package stringset provides a basic implementation of a set data structure for strings.
// A set is an unordered collection of unique elements.
package stringset

import (
	"fmt"
	"strings"
)

// Set is a data structure that stores a collection of unique strings.
type Set struct {
	inner map[string]bool
}

// New creates and returns a new, empty Set.
func New() Set {
	return Set{inner: map[string]bool{}}
}

// NewFromSlice creates a new Set from a slice of strings.
// It iterates over the slice and adds each element to the Set.
func NewFromSlice(l []string) Set {
	result := New()

	for _, v := range l {
		result.Add(v)
	}

	return result
}

// String returns a string representation of the Set.
// The format is a comma-separated list of its elements enclosed in curly braces.
func (s Set) String() string {
	const format = "{%s}"
	return fmt.Sprintf(format, strings.Join(s.valuesAsStr(), ", "))
}

// IsEmpty checks if the Set contains any elements.
func (s Set) IsEmpty() bool {
	return len(s.inner) == 0
}

// Has checks if a given element exists in the Set.
func (s Set) Has(elem string) bool {
	return s.inner[elem]
}

// Add inserts a new element into the Set.
// If the element already exists, the Set remains unchanged.
func (s Set) Add(elem string) {
	s.inner[elem] = true
}

// Subset checks if Set s1 is a subset of Set s2.
// It returns true if all elements of s1 are also in s2.
func Subset(s1, s2 Set) bool {
	if s1.IsEmpty() {
		return true
	}
	if s2.IsEmpty() {
		return false
	}

	for value := range s1.inner {
		if !s2.Has(value) {
			return false
		}
	}
	return true
}

// Disjoint checks if two sets are disjoint, meaning they have no common elements.
func Disjoint(s1, s2 Set) bool {
	return Intersection(s1, s2).IsEmpty()
}

// Equal checks if two sets are equal, meaning they contain the same elements.
func Equal(s1, s2 Set) bool {
	if len(s1.inner) != len(s2.inner) {
		return false
	}
	for value := range s1.inner {
		if !s2.Has(value) {
			return false
		}
	}
	return true
}

// Intersection returns a new Set containing all elements that are present in both s1 and s2.
func Intersection(s1, s2 Set) Set {
	intersection := New()

	for value := range s1.inner {
		if s2.Has(value) {
			intersection.Add(value)
		}
	}

	return intersection
}

// Difference returns a new Set containing all elements that are in s1 but not in s2.
func Difference(s1, s2 Set) Set {
	difference := New()

	for value := range s1.inner {
		if !s2.Has(value) {
			difference.Add(value)
		}
	}

	return difference
}

// Union returns a new Set containing all unique elements from both s1 and s2.
func Union(s1, s2 Set) Set {
	union := New()

	for _, set := range []Set{s1, s2} {
		for value := range set.inner {
			union.Add(value)
		}
	}

	return union
}

// valuesAsStr is a private helper method that returns a slice of string representations of the Set's elements.
func (s Set) valuesAsStr() []string {
	theValues := make([]string, 0, len(s.inner))

	for value := range s.inner {
		theValues = append(theValues, valuesAsStr(value))
	}

	return theValues
}

// valuesAsStr is a private helper function that formats a single string value by enclosing it in double quotes.
func valuesAsStr(value string) string {
	const format = "\"%s\""
	return fmt.Sprintf(format, value)
}
