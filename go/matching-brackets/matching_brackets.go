// Package brackets provides functionality to verify whether brackets in a string are correctly paired and nested.
package matchingbrackets

import "slices"

// Bracket reports whether all brackets, braces, and parentheses in input are correctly matched and nested.
func Bracket(input string) bool {
	checker, _ := newBrecketChecker(
		[]rune{'[', '(', '{'},
		[]rune{']', ')', '}'},
	)
	return checker.check(input)
}

// newBrecketChecker creates a new bracketChecker with paired opening and closing symbols.
func newBrecketChecker(openers, closers []rune) (*bracketChecker, error) {
	if len(openers) != len(closers) {
		return &bracketChecker{}, nil
	}

	return &bracketChecker{opener: openers, closer: closers}, nil
}

// check verifies that all brackets in text are correctly balanced.
func (bc *bracketChecker) check(text string) bool {
	stack := bracketStack{}

	for _, r := range text {
		if !bc.isBracket(r) {
			continue
		}
		if bc.isOpener(r) {
			stack.push(r)
			continue
		}

		success, top := stack.pop()

		if !success {
			return false
		}

		if !bc.doesCloses(r, top) {
			return false
		}
	}

	return stack.isEmpty()
}

// isBracket checks whether candidate is either an opening or closing bracket.
func (bc *bracketChecker) isBracket(candidate rune) bool {
	return slices.Contains(bc.opener, candidate) ||
		slices.Contains(bc.closer, candidate)
}

// isOpener checks whether candidate is an opening bracket.
func (bc *bracketChecker) isOpener(candidate rune) bool {
	return slices.Contains(bc.opener, candidate)
}

// doesCloses checks whether candidate correctly closes the given opening bracket.
func (bc *bracketChecker) doesCloses(candidate, bracket rune) bool {
	return slices.Index(bc.opener, bracket) ==
		slices.Index(bc.closer, candidate)
}

// bracketStack is a stack data structure for tracking opening brackets.
type bracketStack struct {
	len    int
	values []rune
}

// isEmpty reports whether the stack contains no elements.
func (br *bracketStack) isEmpty() bool {
	return br.len == 0
}

// push adds a bracket to the top of the stack.
func (br *bracketStack) push(bracket rune) {
	if br.len == len(br.values) {
		br.values = append(br.values, bracket)
	} else {
		br.values[br.len] = bracket
	}

	br.len++
}

// pop removes and returns the top bracket from the stack, or false if the stack is empty.
func (br *bracketStack) pop() (bool, rune) {
	if br.len == 0 {
		return false, 0
	}
	value := br.values[br.len-1]
	br.len--
	return true, value
}

// bracketChecker validates bracket pairing based on configured opener and closer runes.
type bracketChecker struct {
	opener []rune
	closer []rune
}
