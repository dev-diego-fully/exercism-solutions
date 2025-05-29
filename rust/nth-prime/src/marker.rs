pub(crate) struct Marker {
    marks: Vec<bool>,
    upper_bound: u32,
}

impl Marker {
    pub(crate) fn new(upper_bound: u32) -> Self {
        let mut sieve = Self {
            upper_bound,
            marks: vec![false; (upper_bound + 1) as usize],
        };
        sieve.marks[0] = true;
        sieve.marks[1] = true;
        sieve
    }

    pub(crate) fn mark_multiples(&mut self, value: u32) {
        let multiples = multiples_in_range(value, value.pow(2), self.upper_bound);
        multiples.for_each(|multiple| {
            self.mark_value(multiple);
        });
    }

    pub(crate) fn non_markeds(&self) -> impl Iterator<Item = u32> + use<'_> {
        (crate::primes_info::FIRST_PRIME..self.upper_bound)
            .filter(move |value| !self.is_marked(*value))
    }

    pub(crate) fn is_marked(&self, value: u32) -> bool {
        match self.marks.get(value as usize) {
            Some(is) => *is,
            None => false,
        }
    }

    pub(crate) fn nth(&self, n: usize) -> Option<u32> {
        self.non_markeds().nth(n)
    }

    fn mark_value(&mut self, value: u32) -> bool {
        if value <= self.upper_bound {
            self.marks[value as usize] = true;
            return true;
        }
        false
    }
}

fn multiples_in_range(divisor: u32, min: u32, max: u32) -> impl Iterator<Item = u32> {
    (min..max).step_by(divisor as usize)
}
