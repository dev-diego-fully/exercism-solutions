// Package rotationalcipher implements a simple rotational cipher (Caesar cipher).
package rotationalcipher

import (
	"strings"
)

// RotationalCipher encrypts a plaintext string using a rotational
// cipher with the given shift key.
func RotationalCipher(plain string, shiftKey int) string {
	return strings.Map(
		letterRotator(shiftKey), plain,
	)
}

// letterRotator returns a function that rotates a single rune by
// the given shift key.
func letterRotator(shiftKey int) func(rune) rune {
	return func(r rune) rune {
		return rotateLetter(r, shiftKey)
	}
}

// rotateLetter rotates a single letter rune by the given shift key.
func rotateLetter(letter rune, shiftKey int) rune {
	index := indexFromLetter(letter)

	if index == invalidLetterIndex {
		return letter
	}

	return letterFromIndex(
		rotateLetterIndex(index, shiftKey),
		letterCase(letter),
	)
}

// rotateLetterIndex calculates the new index after rotating a letter
// by the shift key.
func rotateLetterIndex(index, shiftKey int) int {
	const alphabetLength int = 26

	return (index + shiftKey) % alphabetLength
}
