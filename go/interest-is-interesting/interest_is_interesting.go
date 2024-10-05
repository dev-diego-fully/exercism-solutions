package interest

// InterestRate returns the interest rate for the provided balance.
func InterestRate(balance float64) float32 {
	switch {
	case balance < 0:
		return 3.213
	case balance < 1000:
		return 0.5
	case balance < 5000:
		return 1.621
	default:
		return 2.475
	}
}

// Interest calculates the interest for the provided balance.
func Interest(balance float64) float64 {
	return balance * float64(InterestRate(balance)) / 100
}

// AnnualBalanceUpdate calculates the annual balance update, taking into account the interest rate.
func AnnualBalanceUpdate(balance float64) float64 {
	return balance + Interest(balance)
}

// YearsBeforeDesiredBalance calculates the minimum number of years required to reach the desired balance.
func YearsBeforeDesiredBalance(balance, targetBalance float64) int {
	var doYearsCalculation func(float64, float64, int) int
	doYearsCalculation = func(balance, targetBalance float64, years int) int {
		if balance >= targetBalance {
			return years
		} else {
			var nextBalance float64 = AnnualBalanceUpdate(balance)
			return doYearsCalculation(nextBalance, targetBalance, years+1)
		}
	}
	return doYearsCalculation(balance, targetBalance, 0)
}
