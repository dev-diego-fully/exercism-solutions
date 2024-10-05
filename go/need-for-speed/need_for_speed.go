package speed

type Car struct {
	battery      int
	batteryDrain int
	speed        int
	distance     int
}

// NewCar creates a new remote controlled car with full battery and given specifications.
func NewCar(speed, batteryDrain int) Car {
	return Car{
		battery:      100,
		batteryDrain: batteryDrain,
		speed:        speed,
		distance:     0,
	}
}

type Track struct {
	distance int
}

// NewTrack creates a new track
func NewTrack(distance int) Track {
	return Track{
		distance: distance,
	}
}

// Drive drives the car one time. If there is not enough battery to drive one more time,
// the car will not move.
func Drive(car Car) Car {
	if car.battery < car.batteryDrain {
		return car
	} else {
		var newCar Car = NewCar(car.speed, car.batteryDrain)
		newCar.battery = car.battery - newCar.batteryDrain
		newCar.distance = car.distance + newCar.speed
		return newCar
	}
}

// CanFinish checks if a car is able to finish a certain track.
func CanFinish(car Car, track Track) bool {
	var remainingDriveTimes int = car.battery / car.batteryDrain
	var requiredDriveTimes int = track.distance / car.speed
	return remainingDriveTimes >= requiredDriveTimes
}
