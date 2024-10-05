// INFO: Headers from the standard library should be inserted at the top via
// #include <LIBRARY_NAME>


// daily_rate calculates the daily rate given an hourly rate
#include <cmath>
double daily_rate(double hourly_rate) {

    const int daily_hours_worked = 8;

    return daily_hours_worked * hourly_rate;

}

// apply_discount calculates the price after a discount
double apply_discount(double before_discount, double discount) {

    const int base = 100;
    const double remainder = (base - discount)/base;

    return before_discount * remainder;

}

// monthly_rate calculates the monthly rate, given an hourly rate and a discount
// The returned monthly rate is rounded up to the nearest integer.
int monthly_rate(double hourly_rate, double discount) {

    const int monthly_days_workeds = 22;
    const double daily_price = apply_discount(
        daily_rate( hourly_rate ), discount
    );

    return ceil( monthly_days_workeds * daily_price );

}

// days_in_budget calculates the number of workdays given a budget, hourly rate,
// and discount The returned number of days is rounded down (take the floor) to
// the next integer.
int days_in_budget(int budget, double hourly_rate, double discount) {

    const double daily_price = apply_discount(
        daily_rate (hourly_rate), discount
    );
    
    return floor( budget / daily_price );

}