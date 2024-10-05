#include "hexadecimal.h"
#include <cstdio>

namespace hexadecimal {


int convert(char digit) {
    if(isdigit(digit)) {
        return digit - '0';
    }
    if(islower(digit)) {
        return 10 + digit - 'a';
    }
    if(isupper(digit)) {
        return 10 + digit - 'A';
    }
    return -1;
}

int convert(std::string hex_code) {
    const int VALUE_FOR_ERROR = 0;
    const int base = 16;
    std::vector<int> digits;
    int hex_value = 0;

    for(size_t i = 0; i < hex_code.length(); i++) {
        const char current_char = hex_code.at(i);
        const int digit_value = convert(current_char);
        const int current_pow = (hex_code.length() - 1) - i;
        
        if(digit_value < 0 || digit_value > base) {
            return VALUE_FOR_ERROR;
        }

        const int current_value = digit_value * std::pow(base, current_pow);
        hex_value += current_value;
    }

    return hex_value;
}


}  // namespace hexadecimal
