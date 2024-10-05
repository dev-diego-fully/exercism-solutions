package booking

import (
	"fmt"
	"time"
)

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
	const format string = "1/2/2006 15:04:05"

	parsed, _ := time.Parse(format, date)

	return parsed
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	const format string = "January 2, 2006 15:04:05"

	parsed, _ := time.Parse(format, date)

	return parsed.Before(time.Now())
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	const format string = "Monday, January 2, 2006 15:04:05"

	var parsed, _ = time.Parse(format, date)
	var hour = parsed.Hour()

	return hour >= 12 && hour < 18
}

// Description returns a formatted string of the appointment time.
func Description(date string) string {
	const inputFormat string = "1/2/2006 15:04:00"
	const descriptionFormat string = "Monday, January 2, 2006, at 15:04"
	const message string = "You have an appointment on %s."

	parsed, _ := time.Parse(inputFormat, date)
	formated := parsed.Format(descriptionFormat)

	return fmt.Sprintf(message, formated)
}

// AnniversaryDate returns a Time with this year's anniversary.
func AnniversaryDate() time.Time {
	var currentYear int = time.Now().Year()
	var currentYearAniversary time.Time = time.Date(
		currentYear, 9, 15, 0, 0, 0, 0, time.UTC,
	)

	if currentYearAniversary.Before(time.Now()) {
		return time.Date(
			currentYear+1, 9, 15, 0, 0, 0, 0, time.UTC,
		)
	}

	return currentYearAniversary
}
