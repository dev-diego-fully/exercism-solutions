package twelve

import "fmt"

// Song generates the entire "Twelve Days of Christmas" song.
func Song() string {
	song := ""

	for i := 0; i < 12; i++ {
		if i > 0 {
			song += "\n"
		}
		song += Verse(i + 1)
	}

	return song
}

// Verse generates a single verse of the song for a given day.
// The verse for a specific day includes the day's ordinal and the list of gifts.
func Verse(i int) string {
	const verseFormat = "%s: %s"
	return fmt.Sprintf(verseFormat, onDay(i), giftsInDay(i))
}

// onDay generates the introductory line for a verse, specifying the day's ordinal.
func onDay(count int) string {
	const format = "On the %s day of Christmas my true love gave to me"

	return fmt.Sprintf(format, ordinals[count])
}

// giftsInDay generates the list of gifts for a given day, ordered from the current day down to the first.
// It handles the "and" before the final gift correctly.
func giftsInDay(count int) string {
	const mainFormat string = "%s, %s %s"
	const andFormat = "%s, and %s %s."
	const initialFormat = "%s %s"
	giftsList := fmt.Sprintf(initialFormat, quantities[count], gifts[count])

	for i := count - 1; i > 0; i-- {
		if i == 1 && count > 1 {
			giftsList = fmt.Sprintf(andFormat, giftsList, quantities[i], gifts[i])
		} else {
			giftsList = fmt.Sprintf(mainFormat, giftsList, quantities[i], gifts[i])
		}
	}

	if count == 1 {
		return giftsList + "."
	}
	return giftsList
}

// quantities maps day numbers to the quantity string for the gift on that day.
var quantities = map[int]string{
	1:  "a",
	2:  "two",
	3:  "three",
	4:  "four",
	5:  "five",
	6:  "six",
	7:  "seven",
	8:  "eight",
	9:  "nine",
	10: "ten",
	11: "eleven",
	12: "twelve",
}

// ordinals maps day numbers to their ordinal names.
var ordinals = map[int]string{
	1:  "first",
	2:  "second",
	3:  "third",
	4:  "fourth",
	5:  "fifth",
	6:  "sixth",
	7:  "seventh",
	8:  "eighth",
	9:  "ninth",
	10: "tenth",
	11: "eleventh",
	12: "twelfth",
}

// gifts maps day numbers to the name of the gift given on that day.
var gifts = map[int]string{
	1:  "Partridge in a Pear Tree",
	2:  "Turtle Doves",
	3:  "French Hens",
	4:  "Calling Birds",
	5:  "Gold Rings",
	6:  "Geese-a-Laying",
	7:  "Swans-a-Swimming",
	8:  "Maids-a-Milking",
	9:  "Ladies Dancing",
	10: "Lords-a-Leaping",
	11: "Pipers Piping",
	12: "Drummers Drumming",
}
