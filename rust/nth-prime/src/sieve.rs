use crate::marker;
use crate::primes_info;

pub(crate) struct Sieve {
    marks: marker::Marker,
    upper_bound: u32,
}

impl Sieve {
    pub(crate) fn just_get_nth(n: usize) -> u32 {
        let upper_bound = primes_info::estimated_nth_prime(n);
        Self::executed(upper_bound).nth(n)
    }

    fn executed(upper_bound: u32) -> Self {
        let mut sieve = Sieve::new(upper_bound);
        sieve.compute_primes();
        sieve
    }

    fn new(upper_bound: u32) -> Self {
        Self {
            marks: marker::Marker::new(upper_bound),
            upper_bound,
        }
    }

    fn compute_primes(&mut self) {
        let computing_limit = (self.upper_bound as f32).sqrt().ceil() as u32;

        (primes_info::FIRST_PRIME..computing_limit).for_each(|value| {
            if !self.marks.is_marked(value) {
                self.marks.mark_multiples(value);
            }
        });
    }

    fn nth(&mut self, n: usize) -> u32 {
        self.marks.nth(n).unwrap()
    }
}
