package collatzconjecture

import "errors"

func collatzNumber(n int) int {
	if n%2 == 0 {
		return n / 2
	}
	return 3*n + 1
}

func CollatzConjecture(n int) (int, error) {
	if n < 1 {
		return 0, errors.New("Invalid Value")
	}

	var current int = n
	var steps int = 0

	for current > 1 {
		steps++
		current = collatzNumber(current)
	}

	return steps, nil
}
