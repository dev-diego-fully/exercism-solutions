use crate::marker;
use crate::primes_info;

/// Sieve is a type used to implement the "Sieve of Erastotenes".
/// Its main use is to hide the execution of each step of the sievealgorithm.
pub(crate) struct Sieve {
    marks: marker::Marker,
    upper_bound: u32,
}

impl Sieve {
    /// Returns the nth prime number, obtained by executing a sieve.
    /// Removes the need to expose a Sieve instance to the user who
    /// only wants the nth prime number.
    pub(crate) fn just_get_nth(n: usize) -> u32 {
        let upper_bound = primes_info::estimated_nth_prime(n);
        Self::executed(upper_bound).nth(n)
    }

    /// Returns an instance of the sieve, but after having already executed
    /// its prime selection process.
    ///
    /// Internally, it creates an instance of the sieve, then executes the
    /// search for primes and finally, returns the previously created
    /// instance of the sieve.
    fn executed(upper_bound: u32) -> Self {
        let mut sieve = Sieve::new(upper_bound);
        sieve.compute_primes();
        sieve
    }

    /// Returns an instance of Sieve that is prepared to search for prime
    /// numbers only up to the defined upper_bound.
    fn new(upper_bound: u32) -> Self {
        Self {
            marks: marker::Marker::new(upper_bound),
            upper_bound,
        }
    }

    /// Performs the search for prime numbers for this sieve.
    /// After the end of this function, all prime and non-prime numbers will
    /// be properly marked within their internal Marker.
    fn compute_primes(&mut self) {
        let computing_limit = (self.upper_bound as f32).sqrt().ceil() as u32;

        (primes_info::FIRST_PRIME..computing_limit).for_each(|value| {
            if !self.marks.is_marked(value) {
                self.marks.mark_multiples(value);
            }
        });
    }


    /// Returns the nth prime number of this sieve.
    /// 
    /// This operation is only valid when compute_primes has already been
    /// executed and if called before that it returns a garbage value.
    /// 
    /// If called with a value that exceeds the upper_bound of the sieve,
    /// it will cause a panic.
    fn nth(&mut self, n: usize) -> u32 {
        self.marks.non_markeds().nth(n).unwrap()
    }
}
