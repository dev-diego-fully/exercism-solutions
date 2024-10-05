// interest_rate returns the interest rate for the provided balance.
double interest_rate(double balance) {
    
    const double required_for_rate_2 = 0;
    const double required_for_rate_3 = 1000;
    const double required_for_rate_4 = 5000;

    const double rate_1 = 3.213;
    const double rate_2 = 0.5;
    const double rate_3 = 1.621;
    const double rate_4 = 2.475;

    if(balance < required_for_rate_2)
        return rate_1;

    if(balance < required_for_rate_3)
        return rate_2;

    if(balance < required_for_rate_4)
        return rate_3;

    return rate_4;

}

// yearly_interest calculates the yearly interest for the provided balance.
double yearly_interest(double balance) {

    const double percent = 0.01;

    return balance * interest_rate( balance ) * percent;

}

// annual_balance_update calculates the annual balance update, taking into
// account the interest rate.
double annual_balance_update(double balance) {

    return balance + yearly_interest(balance);

}

// years_until_desired_balance calculates the minimum number of years required
// to reach the desired balance.
int years_until_desired_balance(double balance, double target_balance) {

    int needed_years = 0;
    double current_balance = balance;

    while( current_balance < target_balance ) {
        current_balance = annual_balance_update(current_balance);
        needed_years++;
    }

    return needed_years;
    
}