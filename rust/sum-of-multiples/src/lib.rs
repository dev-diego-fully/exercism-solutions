/// Returns the sum of integers in the range [1, limit)
/// that are multiples of the given factors.
pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    (1..limit).filter(|val| has_divisor_in(val, factors)).sum()
}

/// Checks if the given value is a multiple of any of the given factors.
fn has_divisor_in(value: &u32, factors: &[u32]) -> bool {
    factors
        .iter()
        .any(|factor| *factor != 0 && value % *factor == 0)
}
