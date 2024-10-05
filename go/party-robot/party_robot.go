package partyrobot

import "fmt"

// Welcome greets a person by name.
func Welcome(name string) string {
	const welcomeMsg string = "Welcome to my party, %s!"
	return fmt.Sprintf(welcomeMsg, name)
}

// HappyBirthday wishes happy birthday to the birthday person and exclaims their age.
func HappyBirthday(name string, age int) string {
	const happyBirthdayMsg string = "Happy birthday %s! You are now %d years old!"
	return fmt.Sprintf(happyBirthdayMsg, name, age)
}

// AssignTable assigns a table to each guest.
func AssignTable(name string, table int, neighbor, direction string, distance float64) string {
	const assignTableMsg string = "%s\n%s\n%s"
	const tableLine string = "You have been assigned to table %03d. Your table is %s, exactly %.1f meters from here."
	const neighborLine string = "You will be sitting next to %s."

	var welcomeLine string = Welcome(name)
	var tableMsg = fmt.Sprintf(tableLine, table, direction, distance)
	var neighborMsg = fmt.Sprintf(neighborLine, neighbor)

	return fmt.Sprintf(assignTableMsg, welcomeLine, tableMsg, neighborMsg)

}
