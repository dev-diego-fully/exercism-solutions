#include "collatz_conjecture.h"
#include <stdexcept>

namespace collatz_conjecture {


int collatz_number(const int number) {
    if(number % 2 == 0) {
        return number / 2;
    }

    return 3 * number + 1;
}

int steps(const int number, const unsigned int steps_count) {
    if(number == 1) {
        return steps_count;
    }

    return steps(collatz_number(number), steps_count + 1);
}

int steps(const int number) {
    if(number <= 0) {
        throw std::domain_error("Collatz are not possible for non negative numbers.");
    }
    
    return steps(number, 0);
}

}  // namespace collatz_conjecture
