/// Calculates the square of the sum of the integers in the range [1, n].
pub fn square_of_sum(n: u32) -> u32 {
    (1..n + 1).sum::<u32>().pow(2)
}

/// Returns the sum of the squares of the integers in the range [1, n].
pub fn sum_of_squares(n: u32) -> u32 {
    (1..n + 1).map(|value| value.pow(2)).sum()
}

/// Calculates the square of the sum of the integers in [1, n] subtracted
/// by the sum of the squares of the integers in [1, n].
pub fn difference(n: u32) -> u32 {
    square_of_sum(n) - sum_of_squares(n)
}
