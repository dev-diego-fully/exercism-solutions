package lasagna

const OvenTime int = 40

// RemainingOvenTime returns the remaining minutes based on the `actual` minutes already in the oven.
func RemainingOvenTime(actualMinutesInOven int) int {
	const minMinutesRemaining int = 0
	var remainingTime int = OvenTime - actualMinutesInOven

	if remainingTime > minMinutesRemaining {
		return remainingTime
	} else {
		return minMinutesRemaining
	}
}

// PreparationTime calculates the time needed to prepare the lasagna based on the amount of layers.
func PreparationTime(numberOfLayers int) int {
	const minutesPerLayer int = 2
	return minutesPerLayer * numberOfLayers
}

// ElapsedTime calculates the time elapsed cooking the lasagna. This time includes the preparation time and the time the lasagna is baking in the oven.
func ElapsedTime(numberOfLayers int, actualMinutesInOven int) int {
	return PreparationTime(numberOfLayers) + actualMinutesInOven
}
