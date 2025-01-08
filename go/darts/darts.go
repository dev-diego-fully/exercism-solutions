package darts

import "math"

// Score calculates the score of the throw according to the area of ​
// the target the dart hit. The deeper the area, the higher the score.
func Score(x, y float64) int {
	distance := distanceFromCenter(x, y)

	for _, zone := range targetZones {
		if float64(zone.size) >= distance {
			return zone.score
		}
	}

	return scoreForMissingTarget
}

// distanceFromCenter calculates the distance at which the point given
// by (x, y) is from the center point (0, 0).
func distanceFromCenter(x, y float64) float64 {
	return math.Sqrt(x*x + y*y)
}

const scoreForMissingTarget int = 0

// targetZones gathers all the zones that the target has:
// inner, middle and outer
var targetZones = []targetZone{
	{1, 10},
	{5, 5},
	{10, 1},
}

// targetZone represents a zone of the target, grouping the size and
// score of the zone.
type targetZone struct {
	size, score int
}
