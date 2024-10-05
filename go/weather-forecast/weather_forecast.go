// Package weather provides tools for working with the weather forecast.
package weather

// CurrentCondition stores the last predicted weather condition.
var CurrentCondition string

// CurrentLocation stores the last city in which the weather was predicted..
var CurrentLocation string

// Forecast updates the weather forecast based on past parameters and returns
// a message, in string form, of the weather forecast.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
