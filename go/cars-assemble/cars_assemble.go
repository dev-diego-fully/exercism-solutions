package cars

// CalculateWorkingCarsPerHour calculates how many working cars are
// produced by the assembly line every hour.
func CalculateWorkingCarsPerHour(productionRate int, successRate float64) float64 {
	return float64(productionRate) * successRate / 100
}

// CalculateWorkingCarsPerMinute calculates how many working cars are
// produced by the assembly line every minute.
func CalculateWorkingCarsPerMinute(productionRate int, successRate float64) int {
	return int(
		CalculateWorkingCarsPerHour(productionRate, successRate) / 60.0,
	)
}

// CalculateCost works out the cost of producing the given number of cars.
func CalculateCost(carsCount int) uint {
	const costPerCar int = 10000
	const costPerGroup int = 95000

	var groupOfTen int = carsCount / 10
	var individualCars int = carsCount % 10

	return uint(groupOfTen*costPerGroup + costPerCar*individualCars)
}
