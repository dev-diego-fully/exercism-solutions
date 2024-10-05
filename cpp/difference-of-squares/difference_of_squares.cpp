#include "difference_of_squares.h"
#include <cmath>

namespace difference_of_squares {

int do_sum_of_squares(int current, int previous_sum) {
    if(current < 0) {
        return -1;
    }
    if(current == 0) {
        return previous_sum;
    }
    
    const int square = std::pow(current, 2);
    const int next = current - 1;

    return do_sum_of_squares(next, previous_sum + square);
}

int do_square_of_sum(int current, int previous_sum) {
    if(current < 0) {
        return -1;
    }
    if(current == 0) {
        return std::pow(previous_sum, 2);
    }
    const int next = current - 1;
    const int current_sum = previous_sum + current;
    return do_square_of_sum(next, current_sum);
}

int sum_of_squares(int last) {
    return do_sum_of_squares(last, 0);
}

int square_of_sum(int last) {
    return do_square_of_sum(last, 0);
}

int difference(int last) {
    return square_of_sum(last) - sum_of_squares(last);  
}

}  // namespace difference_of_squares
