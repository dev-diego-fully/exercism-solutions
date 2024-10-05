package raindrops

import "strconv"

func Convert(number int) string {
	const soundFor3 = "Pling"
	const soundFor5 = "Plang"
	const soundFor7 = "Plong"

	var sound = ""

	if number%3 == 0 {
		sound += soundFor3
	}
	if number%5 == 0 {
		sound += soundFor5
	}
	if number%7 == 0 {
		sound += soundFor7
	}
	if sound == "" {
		return strconv.Itoa(number)
	}
	return sound
}
