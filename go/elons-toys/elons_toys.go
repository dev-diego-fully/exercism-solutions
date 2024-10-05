package elon

import "fmt"

// Drive try to drive a car one time if has battery remaining for this
func (car *Car) Drive() {
	if car.battery >= car.batteryDrain {
		car.battery -= car.batteryDrain
		car.distance += car.speed
	}
}

func (car Car) DisplayDistance() string {
	const distanceDisplayTemplate string = "Driven %d meters"

	return fmt.Sprintf(distanceDisplayTemplate, car.distance)
}

func (car Car) DisplayBattery() string {
	const displayBatteryTemplate string = "Battery at %d%%"

	return fmt.Sprintf(displayBatteryTemplate, car.battery)
}

func (car Car) CanFinish(trackDistance int) bool {
	batteryEfficience := float64(car.speed) / float64(car.batteryDrain)
	requiredEfficience := float64(trackDistance) / float64(car.battery)
	return batteryEfficience >= requiredEfficience
}
