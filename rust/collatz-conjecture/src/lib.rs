/// Calculates and returns the number of steps required to go
/// from n to 1, following the Collatz function.
pub fn collatz(n: u64) -> Option<u64> {
    if n == 0 {
        None
    } else {
        Some(Collatz::new(n, 1).count() as u64)
    }
}

/// Iterator for the Collatz problem.
struct Collatz {
    target: u64,
    current: u64,
}

impl Collatz {
    /// Creates a new iterator for the Collatz problem.
    /// Receives a starting iteration value and a stopping value.
    /// (Stops when it finds the given value)
    fn new(start: u64, target: u64) -> Self {
        Self {
            current: start,
            target,
        }
    }

    /// Returns the next collatz value for the current number.
    fn next_collatz(&self) -> u64 {
        if self.current % 2 == 0 {
            self.current / 2
        } else {
            3 * self.current + 1
        }
    }
}

impl Iterator for Collatz {
    type Item = u64;

    fn next(&mut self) -> Option<u64> {
        if self.current == self.target {
            None
        } else {
            self.current = self.next_collatz();
            Some(self.current)
        }
    }
}
