package lasagna

// publics
func PreparationTime(layers []string, minutesPerLayer int) int {
	if minutesPerLayer <= 0 {
		return len(layers) * 2
	}
	return len(layers) * minutesPerLayer
}

func Quantities(layers []string) (int, float64) {
	const noodlesPerLayer int = 50
	const saucePerLayer float64 = 0.2

	var totalNoodles int = 0
	var totalSauce float64 = 0

	for i := 0; i < len(layers); i++ {
		if layers[i] == "noodles" {
			totalNoodles += noodlesPerLayer
		} else if layers[i] == "sauce" {
			totalSauce += saucePerLayer
		}
	}

	return totalNoodles, totalSauce
}

func AddSecretIngredient(friendsRecipe []string, myRecipe []string) []string {
	var secretIngredient string = friendsRecipe[len(friendsRecipe)-1]
	myRecipe[len(myRecipe)-1] = secretIngredient

	return myRecipe
}

func ScaleRecipe(quantities []float64, portions int) []float64 {
	const originalYieldment int = 2

	var scaledQuantities []float64 = make([]float64, len(quantities))

	for i := 0; i < len(quantities); i++ {
		scaledQuantities[i] = scale(quantities[i], originalYieldment, portions)
	}

	return scaledQuantities
}

// privates
func scale(quantity float64, originalYieldment, newYieldment int) float64 {
	return (quantity / float64(originalYieldment)) * float64(newYieldment)
}
