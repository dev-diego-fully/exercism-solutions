#include "collatz_conjecture.h"

int collatz(int number);

int collatz(int number) {
    if(number % 2 == 0) {
        return number / 2;
    }
    return 3 * number + 1;
}

int steps(int start) {
    const int error = -1;
    
    if(start < 1) {
        return error;
    }

    int current = start;
    int total_steps = 0;

    while (current != 1) {
        total_steps ++;
        current = collatz(current);
    }

    return total_steps;
}