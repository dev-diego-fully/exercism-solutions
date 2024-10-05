#include "trinary.h"
#include <cctype>
#include <cmath>
#include <cstddef>

namespace trinary {

const int DIGIT_PARSE_ERROR = -1;

int digit_parse(char digit) {

    if(isdigit(digit)) {
        return digit - '0';
    }
    if(isupper(digit)) {
        return digit - 'a';
    }
    if(islower(digit)) {
        return digit - 'A';
    }

    return DIGIT_PARSE_ERROR;
}

int digit_value(int digit, size_t position, size_t base = 2) {
    return digit * std::pow(base, position);
}

int to_decimal(std::string trinary) {
    const int base = 3;
    const int value_for_error = 0;
    int decimal = 0;

    for(size_t i = 0; i < trinary.length(); i++) {
        const char current_digit = digit_parse(trinary.at(i));
        const int current_position = trinary.length() - 1 - i;
        if(current_digit == DIGIT_PARSE_ERROR || current_digit > base) {
            return value_for_error;
        }
        decimal += digit_value(current_digit, current_position, base);
    }

    return decimal;
}

}  // namespace trinary
