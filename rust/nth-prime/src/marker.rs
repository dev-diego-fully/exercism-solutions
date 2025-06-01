/// Marker is a type of continuous number marker. It is used to facilitate
/// the process of marking, checking marking and recovering numbers (marked
/// or not) within the marker.
///
/// Their marker has elements ranging from 2 to upper_bound.
///
/// In practice, it has the values ​​0 and 1, but these start marked. This
/// is a slight waste of memory, but makes the index of a value equal
/// to the value itself. This avoids the overhead of having to correct the
/// index of a value every time you try to reference a value.
pub(crate) struct Marker {
    upper_bound: u32,
    marks: Vec<bool>,
}

impl Marker {
    /// Returns a new instance of Marker that has elements from 2 to
    /// upper_bound.
    pub(crate) fn new(upper_bound: u32) -> Self {
        let mut sieve = Self {
            upper_bound,
            marks: vec![false; (upper_bound + 1) as usize],
        };
        sieve.marks[0] = true;
        sieve.marks[1] = true;
        sieve
    }

    /// Mark all values ​​within the range covered by the marker that are
    /// multiples of the given value.
    pub(crate) fn mark_multiples(&mut self, value: u32) {
        let multiples = multiples_in_range(value, value.pow(2), self.upper_bound);
        multiples.for_each(|multiple| {
            self.mark_value(multiple);
        });
    }

    /// Returns an iterator containing each element within the marker, in
    /// ascending order, that has not been marked.
    pub(crate) fn non_markeds(&self) -> impl Iterator<Item = u32> + use<'_> {
        (crate::primes_info::FIRST_PRIME..self.upper_bound)
            .filter(move |value| !self.is_marked(*value))
    }

    /// Returns whether the given value has been marked or not.
    ///
    /// Returns false if the value is outside the range covered
    /// by the marker.
    pub(crate) fn is_marked(&self, value: u32) -> bool {
        match self.marks.get(value as usize) {
            Some(is) => *is,
            None => false,
        }
    }

    /// If the value provided is within the range covered by marker, then it
    /// marks that value and returns true.
    ///
    /// Otherwise, it returns false.
    fn mark_value(&mut self, value: u32) -> bool {
        if value <= self.upper_bound {
            self.marks[value as usize] = true;
            return true;
        }
        false
    }
}

/// Returns an iterator that generates, in ascending order, all numbers in
/// [min, max) that are divisible by the `divisor`.
fn multiples_in_range(divisor: u32, min: u32, max: u32) -> impl Iterator<Item = u32> {
    (min..max).step_by(divisor as usize)
}
