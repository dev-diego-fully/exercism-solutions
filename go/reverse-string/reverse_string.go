package reverse

import "strings"

func Reverse(input string) string {
	var chars []string = strings.Split(input, "")
	var reversed []string

	for i := len(chars) - 1; i >= 0; i-- {
		reversed = append(reversed, chars[i])
	}

	return strings.Join(reversed, "")
}
