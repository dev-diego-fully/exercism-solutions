package proverb

import "fmt"

// Proverb generates the complete "For want of a..." proverb.
// It takes a slice of strings, where each string is an item in the rhyming chain.
// The function returns a slice of strings, with each string representing a line of the proverb.
func Proverb(rhyme []string) []string {
	limit := len(rhyme) - 1
	verses := []string{}

	if limit < 0 {
		return verses
	}

	for i := 0; i < limit; i++ {
		verses = append(verses, lineForWantWasLost(rhyme[i], rhyme[i+1]))
	}

	verses = append(verses, allForAWant(rhyme[0]))

	return verses
}

// lineForWantWasLost formats a single line of the proverb, connecting a "wanted" item to a "lost" item.
func lineForWantWasLost(wanted, lost string) string {
	const linePattern = "For want of a %s the %s was lost."
	return fmt.Sprintf(linePattern, wanted, lost)
}

// allForAWant formats the final summary line of the proverb, which references the first item in the chain.
func allForAWant(wanted string) string {
	const linePattern = "And all for the want of a %s."
	return fmt.Sprintf(linePattern, wanted)
}
