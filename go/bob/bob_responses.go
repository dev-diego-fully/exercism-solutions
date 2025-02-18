package bob

// answerAndCheckers maps patterns to Bob's responses.
var answerAndCheckers = [][]string{
	{"Calm down, I know what I'm doing!", `^[^a-z]*[A-Z][^a-z]*\?\s*$`}, // Response to yelling a question
	{"Whoa, chill out!", `^[^a-z]*[A-Z][^a-z]*$`},                       // Response to yelling
	{"Sure.", `\?\s*$`},             // Response to a question
	{"Fine. Be that way!", `^\s*$`}, // Response to silence
	{"Whatever.", `.*`},             // Default response
}
