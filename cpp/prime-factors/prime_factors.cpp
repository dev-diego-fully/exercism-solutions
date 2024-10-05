#include "prime_factors.h"


namespace prime_factors {

std::vector<int> candidates(const int number) {
    std::vector<int> numbers;

    for(int i = 2; i <= number; i++) {
        numbers.push_back(i);
    }

    return numbers;
}

std::vector<int> primes_to(const std::vector<int> numbers, const int prime) {
    std::vector<int> primes;

    for(const int number: numbers) {
        if(number == prime || number % prime != 0) {
            primes.push_back(number);
        }
    }

    return primes;
}

std::vector<int> primes_at(const int value) {
    std::vector<int> primes = candidates(value);
    
    for(size_t i = 0; i < primes.size(); i++) {
        primes = primes_to(primes, primes[i]);
    }

    return primes;
}

bool is_prime(const int number) {
    if(number <= 1) {
        return false;
    }

    for(const int prime: primes_at(std::sqrt(number))) {
        if(number % prime == 0) {
            return false;
        }
    }

    return true;
}

std::vector<int> of(const int number) {
    const int no_factor = -1;
    
    if(number < 2) {
        return {};
    }

    if(is_prime(number)) {
        return {number};
    }

    int factor = no_factor;
    for(const int prime: primes_at(std::sqrt(number))) {
        if(number % prime == 0) {
            factor = prime;
            break;
        }
    }
    
    if(factor == no_factor) {
        return {};
    }

    std::vector<int> factors = of(number / factor);
    factors.push_back(factor);
    std::sort(factors.begin(), factors.end());

    return factors;
}


}  // namespace prime_factors
