package parsinglogfiles

import (
	"fmt"
	"regexp"
)

func IsValidLine(text string) bool {
	const validLine string = `^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`

	var validLineRegex = regexp.MustCompile(validLine)

	return validLineRegex.MatchString(text)
}

func SplitLogLine(text string) []string {
	const splitter string = `\<(\~|\*|\=|\-)*\>`

	var splitterRegexp = regexp.MustCompile(splitter)

	return splitterRegexp.Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	const quotedPasswords string = `(?i)".*password.*"`

	var quotedPasswordsRegex = regexp.MustCompile(quotedPasswords)

	var count = 0

	for _, line := range lines {
		if quotedPasswordsRegex.MatchString(line) {
			count += 1
		}
	}

	return count
}

func RemoveEndOfLineText(text string) string {
	const endOfLine string = `end-of-line(\d+)`
	const deletedString string = ""

	var endOfLineRegex = regexp.MustCompile(endOfLine)

	return endOfLineRegex.ReplaceAllString(text, deletedString)
}

func TagWithUserName(lines []string) []string {

	const userFinder = `User\s+(\S+)`
	const userPrefixed = "[USR] %s %s"

	var userFinderRegex = regexp.MustCompile(userFinder)

	var newLines []string = make([]string, len(lines))

	for index, line := range lines {

		userMatch := userFinderRegex.FindStringSubmatch(line)
		userExist := userMatch != nil

		if userExist {
			user := userMatch[1]
			newLines[index] = fmt.Sprintf(userPrefixed, user, line)
		} else {
			newLines[index] = line
		}
	}

	return newLines
}
