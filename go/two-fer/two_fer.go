package twofer

import "fmt"

// ShareWith generates a sharing message in the format
// "One for <name>, one for me.". If the name is empty,
// it defaults to "you".
func ShareWith(name string) string {
	const defaultPronoun string = "you"
	const shareMessageFormat string = "One for %s, one for me."

	if name != "" {
		return fmt.Sprintf(shareMessageFormat, name)
	}

	return fmt.Sprintf(shareMessageFormat, defaultPronoun)
}
