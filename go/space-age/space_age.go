package space

type Planet string

// Age converts a value in seconds to years on the given planet.
// If the planet is invalid, it returns -1.
func Age(seconds float64, planet Planet) float64 {
	planetOrbitalPeriod, validPlanet := orbitalPeriod[planet]

	if !validPlanet {
		return -1
	}

	return secondsToEarthYear(seconds) / planetOrbitalPeriod
}

// secondsToEarthYear converts seconds to Earth years.
// Assumes an Earth year has 365.25 days.
func secondsToEarthYear(seconds float64) float64 {
	const earthYearInSeconds = 365.25 * 24 * 60 * 60
	return seconds / earthYearInSeconds
}

var orbitalPeriod = map[Planet]float64{
	"Mercury": 0.2408467,
	"Venus":   0.61519726,
	"Earth":   1,
	"Mars":    1.8808158,
	"Jupiter": 11.862615,
	"Saturn":  29.447498,
	"Uranus":  84.016846,
	"Neptune": 164.79132,
}
