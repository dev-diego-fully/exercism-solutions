use crate::marker;

pub(crate) struct Sieve {
    primes: Vec<u64>,
    last_checked: usize,
}

impl Sieve {
    const FIRST_PRIME: u64 = 2;
    const SECONDS_PRIME: u64 = 3;

    pub(crate) fn just_get_primes(upper_bound: u64) -> Vec<u64> {
        Self::new().upper_to(upper_bound)
    }

    fn new() -> Self {
        Self {
            primes: vec![Self::FIRST_PRIME, Self::SECONDS_PRIME],
            last_checked: 1,
        }
    }

    fn get_current(&self) -> u64 {
        self.primes[self.last_checked]
    }

    fn next_interval_start(&self) -> u64 {
        self.primes[self.last_checked - 1].pow(2)
    }

    fn next_interval_end(&self) -> u64 {
        self.get_current().pow(2)
    }

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

    fn upper_to(&mut self, upper_bound: u64) -> Vec<u64> {
        while self.primes[self.primes.len() - 1] < upper_bound {
            self.expand()
        }
        self.primes
            .iter()
            .take_while(|prime| **prime <= upper_bound)
            .copied()
            .collect()
    }
}
