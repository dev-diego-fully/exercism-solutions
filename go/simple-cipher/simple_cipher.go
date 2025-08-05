package cipher

import (
	"regexp"
	"strings"
)

// ALPHABET_SIZE is the number of letters in the English alphabet.
const ALPHABET_SIZE int = 26

// CAESAR_SHIFT is the default shift distance for the Caesar cipher.
const CAESAR_SHIFT int = 3

// vigenere represents a Vigenère cipher.
// It holds the rotations for each letter of the key.
type vigenere struct {
	rotations []int
}

// NewCaesar creates a new Caesar cipher.
// It is a shift cipher with a default shift of 3.
func NewCaesar() Cipher {
	return NewShift(CAESAR_SHIFT)
}

// NewShift creates a new shift cipher with a given distance.
// It returns nil if the distance is invalid (0 or a multiple of 26).
func NewShift(distance int) Cipher {
	if distance == 0 || distance >= ALPHABET_SIZE || distance <= -ALPHABET_SIZE {
		return nil
	}
	return vigenere{rotations: []int{distance}}
}

// NewVigenere creates a new Vigenère cipher with a given key.
// It returns nil if the key is invalid (e.g., empty, not all letters, or all 'a's).
func NewVigenere(key string) Cipher {
	if isValidKey(key) {
		return vigenere{rotations: toRotations(key)}
	}
	return nil
}

// Encode applies the Vigenère cipher to encode a string.
// It normalizes the input, then rotates each letter by the corresponding key rotation.
func (v vigenere) Encode(input string) string {
	runes := []rune(normalize(input))
	encode := make([]rune, 0, len(runes))

	for index, run := range runes {
		encode = append(encode, rotateLetter(run, v.getRotation(index)))
	}

	return string(encode)
}

// Decode applies the Vigenère cipher to decode a string.
// It reverses the rotation for each letter.
func (v vigenere) Decode(input string) string {
	runes := []rune(input)
	decode := make([]rune, 0, len(runes))

	for index, run := range runes {
		decode = append(decode, deRotateLetter(run, v.getRotation(index)))
	}

	return string(decode)
}

// getRotation retrieves the rotation shift for a specific letter index,
// handling the cyclical nature of the Vigenère key.
func (v vigenere) getRotation(index int) int {
	return v.rotations[index%len(v.rotations)]
}

// normalize cleans up a string by removing non-alphabetic characters
// and converting all letters to lowercase.
func normalize(text string) string {
	pattern := regexp.MustCompile("[^a-zA-Z]")
	cleaned := pattern.ReplaceAllString(text, "")
	return strings.ToLower(cleaned)
}

// toRotations converts a cipher key string into a slice of integer rotations.
// For example, 'a' becomes 0, 'b' becomes 1, etc.
func toRotations(key string) []int {
	runes := []rune(key)
	rotations := make([]int, 0, len(runes))

	for _, run := range runes {
		rotations = append(rotations, int(run-'a'))
	}

	return rotations
}

// rotateLetter shifts a single letter by a given rotation amount,
// wrapping around the alphabet if necessary.
func rotateLetter(run rune, rotation int) rune {
	letterIndex := int(run - 'a')
	newLetterIndex := modulo(letterIndex+rotation, ALPHABET_SIZE)
	return 'a' + rune(newLetterIndex)
}

// deRotateLetter reverses the rotation of a letter by applying a negative rotation.
func deRotateLetter(run rune, rotation int) rune {
	return rotateLetter(run, -rotation)
}

// modulo is a helper function to correctly handle modulo for negative numbers.
func modulo(value, divisor int) int {
	if value < 0 {
		return divisor + value%divisor
	}
	return value % divisor
}

// isValidKey validates a key for the Vigenère cipher.
// The key must contain only lowercase letters and not be composed of only 'a's.
func isValidKey(key string) bool {
	alphaPattern := regexp.MustCompile("^[a-z]+$")
	justAPattern := regexp.MustCompile("^a+$")
	return alphaPattern.MatchString(key) && !justAPattern.MatchString(key)
}
