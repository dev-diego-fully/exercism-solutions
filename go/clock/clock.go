package clock

import "fmt"

const minutesInHours = 60
const hoursInDay = 24
const minutesInDay = minutesInHours * hoursInDay

// Clock represents a time value in minutes within a day.
type Clock uint16

// New creates a Clock instance from the given hours and minutes.
func New(h, m int) Clock {
	return fromInt(h*minutesInHours + m)
}

// Add adds the specified number of minutes to the Clock.
func (c Clock) Add(m int) Clock {
	return fromInt(int(c) + m)
}

// Subtract subtracts the specified number of minutes from the Clock.
func (c Clock) Subtract(m int) Clock {
	return fromInt(int(c) - m)
}

// String returns the time in "HH:MM" format.
func (c Clock) String() string {
	return fmt.Sprintf("%02d:%02d", c.hours(), c.minutes())
}

// hours returns the hour part of the Clock.
func (c Clock) hours() int {
	return int(c / 60)
}

// minutes returns the minute part of the Clock.
func (c Clock) minutes() int {
	return int(c % 60)
}

// fromInt adjusts the value to ensure it fits within the bounds of a single day.
func fromInt(value int) Clock {
	if value >= 0 {
		return Clock(value % minutesInDay)
	}
	return Clock(minutesInDay + (value % -minutesInDay))
}
