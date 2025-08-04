package bottlesong

import (
	"fmt"
	"unicode"
)

// Recite generates a series of verses from the "Ten Green Bottles" song.
// It starts with a specified number of bottles and recites a given number of verses.
func Recite(startBottles, takeDown int) []string {
	verses := []string{}

	for i := 0; i < takeDown; i++ {
		verses = append(verses, verse(startBottles-i)...)
		if i < takeDown-1 {
			verses = append(verses, "")
		}
	}

	return verses
}

// verse generates a single four-line verse of the song for a given number of bottles.
func verse(hangingCount int) []string {
	const lineThree = "And if one green bottle should accidentally fall,"

	lineOneAndTwo := bottlesHangingOnTheWall(hangingCount)
	lineFour := thereWillBeHanging(hangingCount - 1)

	return []string{lineOneAndTwo, lineOneAndTwo, lineThree, lineFour}
}

// bottlesHangingOnTheWall formats the first two lines of a verse.
// It capitalizes the quantity word and handles the pluralization of "bottle".
func bottlesHangingOnTheWall(count int) string {
	const lineFormat = "%s green bottle%s hanging on the wall,"

	sayCount := capitalize(quantities[count])
	terminatorForBottle := tern(count == 1, "", "s")

	return fmt.Sprintf(lineFormat, sayCount, terminatorForBottle)
}

// thereWillBeHanging formats the last line of a verse.
// It states how many bottles are left and handles the pluralization.
func thereWillBeHanging(count int) string {
	const format = "There'll be %s green bottle%s hanging on the wall."

	sayCount := quantities[count]
	terminator := tern(count == 1, "", "s")

	return fmt.Sprintf(format, sayCount, terminator)
}

// tern is a helper function that acts as a simple ternary operator.
// It returns trueCase if the condition is true, otherwise it returns falseCase.
func tern(cond bool, trueCase string, falseCase string) string {
	if cond {
		return trueCase
	} else {
		return falseCase
	}
}

// capitalize is a helper function that capitalizes the first letter of a word.
func capitalize(word string) string {
	runes := []rune(word)
	runes[0] = unicode.ToUpper(runes[0])
	return string(runes)
}

// quantities is a slice that maps integer bottle counts to their corresponding word.
var quantities = []string{
	"no", "one", "two", "three", "four",
	"five", "six", "seven", "eight", "nine", "ten",
}
