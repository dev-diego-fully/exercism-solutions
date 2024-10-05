#include "armstrong_numbers.h"
#include <cmath>
#include <string>
#include <vector>


namespace armstrong_numbers {

int digit_value(const char digit) {
    return digit - '0';
}

std::vector<int> get_digits(const int number) {
    std::vector<int> digits{};

    for(char digit: std::to_string(number)) {
        digits.push_back(digit_value(digit));
    }
    
    return digits;
}

int armstrong_value(const int number) {
    int arm_value = 0;
    const std::vector<int> digits = get_digits(number);

    for(int digit: digits) {
        arm_value += std::pow(digit, digits.size());
    }

    return arm_value;
}

bool is_armstrong_number(const int number) {
    return armstrong_value(number) == number;
}

}  // namespace armstrong_numbers
