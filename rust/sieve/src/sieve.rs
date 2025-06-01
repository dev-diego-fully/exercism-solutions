use crate::marker;

/// Sieve is the type that encapsulates the processing logic to find prime
/// numbers up to a given range.
///
/// This is a segmented version of the Sieve of Eratosthenes and it finds
/// the next prime numbers by advancing the difference of the squares of
/// of the smallest unverified prime and the largest verified prime.
pub(crate) struct Sieve {
    primes: Vec<u64>,
    last_checked: usize,
}

impl Sieve {
    /// Smallest known prime number (the first in ascending order).
    const FIRST_PRIME: u64 = 2;

    /// Second smallest known prime number (second in ascending order).
    const SECONDS_PRIME: u64 = 3;

    /// Returns a vector containing all prime numbers found within the range
    /// FIRST_PRIME to upper_bound.
    ///
    /// Emphasizing that upper_bound will be included in the search range.
    ///
    /// These prime numbers will be obtained using the Erastothene sieve,
    /// but no instance of the sieve will be exposed or kept after the
    /// end of this function.
    pub(crate) fn just_get_primes(upper_bound: u64) -> Vec<u64> {
        Self::new().upper_to(upper_bound).copied().collect()
    }

    /// Returns a Sieve instance of this sieve, but no search execution steps
    /// will have been performed on it.
    fn new() -> Self {
        Self {
            primes: vec![Self::FIRST_PRIME, Self::SECONDS_PRIME],
            last_checked: 1,
        }
    }

    /// Returns the prime number that is currently being used to obtain new
    /// prime numbers.
    fn get_current(&self) -> u64 {
        self.primes[self.last_checked]
    }

    /// Returns the start of the next range in which the next prime numbers
    /// should be searched.
    ///
    /// It is the square of the last (largest) prime checked.
    fn next_interval_start(&self) -> u64 {
        self.primes[self.last_checked - 1].pow(2)
    }

    /// Returns the end of the range in which the next prime numbers should
    /// be searched.
    ///
    /// This is the square of the smallest prime not yet checked.
    fn next_interval_end(&self) -> u64 {
        self.get_current().pow(2)
    }

    /// Expands the list of current primes, searching for new primes in the
    /// range given by next_interval_start to next_interval_end.
    ///
    /// After searching, updates the count of verified primes.
    fn expand(&mut self) {
        let mut marker = marker::Marker::new(self.next_interval_start(), self.next_interval_end());

        marker.mark_multiples_of_all(
            self.primes
                .iter()
                .take_while(|p| p.pow(2) < self.next_interval_end()),
        );

        self.primes.extend(marker.non_markeds());

        self.last_checked += 1
    }

    /// Returns an iterator that produces all prime numbers, in ascending
    /// order, within the range given by FIRST_PRIME up to upper_limit
    /// (inclusive).
    ///
    /// These prime numbers will be obtained by executing the segmented
    /// sieve up to the desired range.
    ///
    /// If a range smaller than or equal to the one previously requested is
    /// requested, no new execution will be made.
    fn upper_to(&mut self, upper_bound: u64) -> impl Iterator<Item = &u64> {
        while self.primes[self.primes.len() - 1] < upper_bound {
            self.expand()
        }
        self.primes
            .iter()
            .take_while(move |prime| **prime <= upper_bound)
    }
}
