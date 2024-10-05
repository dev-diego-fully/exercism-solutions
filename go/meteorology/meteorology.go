package meteorology

import "fmt"

// TemperatureUnit
type TemperatureUnit int

const (
	Celsius    TemperatureUnit = 0
	Fahrenheit TemperatureUnit = 1
)

func (tempUnity TemperatureUnit) String() string {
	const invalidTemperatureUnit string = ""

	const celsiusSymbol string = "°C"
	const fahrenheitSymbol string = "°F"

	switch tempUnity {
	case Celsius:
		return celsiusSymbol
	case Fahrenheit:
		return fahrenheitSymbol
	default:
		return invalidTemperatureUnit
	}
}

// Temperature
type Temperature struct {
	degree int
	unit   TemperatureUnit
}

func (temp Temperature) String() string {
	const temperatureTemplate string = "%d %s"

	return fmt.Sprintf(temperatureTemplate, temp.degree, temp.unit)
}

// SpeedUnit
type SpeedUnit int

const (
	KmPerHour    SpeedUnit = 0
	MilesPerHour SpeedUnit = 1
)

func (speedUnit SpeedUnit) String() string {
	const invalidSpeedUnit string = ""

	const kilometerPerHourSymbol string = "km/h"
	const milesPerHourSymbol string = "mph"

	switch speedUnit {
	case KmPerHour:
		return kilometerPerHourSymbol
	case MilesPerHour:
		return milesPerHourSymbol
	default:
		return invalidSpeedUnit
	}
}

// Speed
type Speed struct {
	magnitude int
	unit      SpeedUnit
}

func (speed Speed) String() string {
	const speedTemplate string = "%d %s"

	return fmt.Sprintf(speedTemplate, speed.magnitude, speed.unit)
}

// MeteorologyData
type MeteorologyData struct {
	location      string
	temperature   Temperature
	windDirection string
	windSpeed     Speed
	humidity      int
}

func (metDat *MeteorologyData) String() string {
	const meteorologyDataTemplate string = "%s: %s, Wind %s at %s, %d%% Humidity"
	location := metDat.location
	temperature := metDat.temperature.String()
	windDirection := metDat.windDirection
	windSpeed := metDat.windSpeed.String()
	humidity := metDat.humidity
	return fmt.Sprintf(
		meteorologyDataTemplate, location, temperature, windDirection, windSpeed, humidity,
	)
}
