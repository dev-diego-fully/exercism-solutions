use std::collections::HashSet;

/// Returns a vector containing all prime numbers less than or equal
/// to upper_bound. This list is obtained using the Sieve of
/// Erastotenes
pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    Sieve::with(upper_bound).get_primes()
}

/// A sieve used to find prime numbers efficiently.
struct Sieve {
    non_primes: HashSet<u64>,
    upper_bound: u64,
}

impl Sieve {
    /// Number defined as the first prime number.
    const FIRST_PRIME: u64 = 2;

    /// Creates a sieve to find prime numbers up to upper_bound.
    fn with(upper_bound: u64) -> Self {
        Self {
            non_primes: HashSet::new(),
            upper_bound,
        }
    }

    /// Marks as non-prime all multiples of numbers up to the upper_bound limit
    /// (passed when creating the sieve).
    fn mark_multiplies(&mut self, number: u64) {
        (number..=self.upper_bound / number)
            .map(|num| num * number)
            .for_each(|multiple| self.mark_value(multiple));
    }

    /// Mark the given number as non-prime.
    fn mark_value(&mut self, value: u64) {
        self.non_primes.insert(value);
    }

    /// Executes the Sieve of Eratosthenes algorithm returning all primes up
    /// to upper_bound (used to create the sieve).
    fn get_primes(&mut self) -> Vec<u64> {
        self.candidates()
            .for_each(|number| self.find_more_primes(number));

        self.candidates()
            .filter(|num| self.is_prime(*num))
            .collect()
    }

    /// Returns whether the given number is still considered a prime by the
    /// sieve at this time.
    fn is_prime(&self, number: u64) -> bool {
        !self.non_primes.contains(&number)
    }

    /// Given a number, register its multiples as non-prime, but only if the
    /// given number is prime.
    fn find_more_primes(&mut self, number: u64) {
        if self.is_prime(number) {
            self.mark_multiplies(number);
        }
    }

    /// Returns an iterator containing the integers that are candidates for
    /// being prime. It starts at FIRST_PRIME (2) and goes up to upper_bound
    /// (used to create the sieve).
    fn candidates(&self) -> impl Iterator<Item = u64> + use<> {
        Self::FIRST_PRIME..=self.upper_bound
    }
}
