pub(crate) struct Marker {
    marks: Vec<bool>,
    start: u64,
    end: u64,
}

impl Marker {
    pub(crate) fn new(start: u64, end: u64) -> Self {
        Self {
            start,
            end,
            marks: vec![false; (end - start) as usize],
        }
    }

    pub(crate) fn non_markeds(self) -> impl Iterator<Item = u64> {
        (self.start..self.end).filter(move |value| !self.is_marked(*value))
    }

    pub(crate) fn mark_multiples_of_all<'a>(&mut self, divisors: impl Iterator<Item = &'a u64>) {
        divisors.for_each(|p| self.mark_multiples(*p));
    }

    fn mark_multiples(&mut self, value: u64) {
        multiples_in_range(value, self.start, self.end)
            .for_each(|multiple| self.mark_value(multiple))
    }

    fn is_marked(&self, value: u64) -> bool {
        match self.index_of(value) {
            Some(index) => self.marks[index],
            None => false,
        }
    }

    fn index_of(&self, value: u64) -> Option<usize> {
        if value < self.start || value >= self.end {
            return None;
        }
        Some((value - self.start) as usize)
    }

    fn mark_value(&mut self, value: u64) {
        match self.index_of(value) {
            None => (),
            Some(index) => self.marks[index] = true,
        }
    }
}

fn multiples_in_range(divisor: u64, min: u64, max: u64) -> impl Iterator<Item = u64> {
    let floor = divisor.pow(2);
    let start = if min % divisor == 0 {
        min.max(floor)
    } else {
        (min + (divisor - min % divisor)).max(floor)
    };

    (start..max).step_by(divisor as usize)
}