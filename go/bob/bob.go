// Package bob provides a function to simulate Bob's responses.
package bob

import "regexp"

// Hey returns Bob's response based on the input remark.
func Hey(remark string) string {
	for _, answerAndChecker := range answerAndCheckers {
		answer, checker := answerAndChecker[0], answerAndChecker[1]
		if regexp.MustCompile(checker).MatchString(remark) {
			return answer
		}
	}
	panic("Programmed response not found.")
}
