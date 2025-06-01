/// Marker is a type that represents a marker of numbers within a given
/// range. It is used to mark numbers within a range as non-prime.
pub(crate) struct Marker {
    marks: Vec<bool>,
    start: u64,
    end: u64,
}

impl Marker {
    /// Returns a new instance of the marker that covers numbers within
    /// the range [start, end).
    pub(crate) fn new(start: u64, end: u64) -> Self {
        Self {
            start,
            end,
            marks: vec![false; (end - start) as usize],
        }
    }

    /// Returns an iterator containing all numbers in the range covered
    /// by the marker that have not been marked.
    pub(crate) fn non_markeds(&self) -> impl Iterator<Item = u64> {
        (self.start..self.end).filter(move |value| !self.is_marked(*value))
    }

    /// For each element of the given iterator, marks all values ​​in the
    /// range covered by that marker that are multiples of that value.
    ///
    /// For optimization reasons, it starts marking only values ​​starting
    /// from the square of the given value of which the multiples are
    /// being marked.
    pub(crate) fn mark_multiples_of_all<'a>(&mut self, divisors: impl Iterator<Item = &'a u64>) {
        divisors.for_each(|p| self.mark_multiples(*p));
    }

    /// Marks numbers within the range covered by the marker that are
    /// multiples of the given value. For optimization reasons in
    /// generating prime numbers, only starts marking values ​​that are
    /// greater than or equal to value^2.
    fn mark_multiples(&mut self, value: u64) {
        multiples_in_range(value, self.end).for_each(|multiple| self.mark_value(multiple))
    }

    /// Returns whether the given value is checked or not.
    fn is_marked(&self, value: u64) -> bool {
        match self.index_of(value) {
            Some(index) => self.marks[index],
            None => false,
        }
    }

    /// If the given value is within the range covered by this marker,
    /// it returns a `Some(index)`. Otherwise, it returns a None.
    fn index_of(&self, value: u64) -> Option<usize> {
        if value < self.start || value >= self.end {
            return None;
        }
        Some((value - self.start) as usize)
    }

    /// Sets the given value (sets its value to true).
    fn mark_value(&mut self, value: u64) {
        match self.index_of(value) {
            None => (),
            Some(index) => self.marks[index] = true,
        }
    }
}

/// Returns all multiples of `divisor` within the range [divisor^2, `max`).
///
/// Starting at divisor^2 is an optimization choice, since numbers smaller
/// than divisor^2 that are divisible by `divisor` will be marked by divisors smaller than `divisor`
fn multiples_in_range(divisor: u64, max: u64) -> impl Iterator<Item = u64> {
    (divisor.pow(2)..max).step_by(divisor as usize)
}
