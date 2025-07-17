//! This module provides functionality to classify numbers based on their aliquot sum.

/// Represents the classification of a number based on its aliquot sum.
#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    /// Indicates that the sum of the number's proper divisors is greater than the number itself.
    Abundant,
    /// Indicates that the sum of the number's proper divisors is equal to the number itself.
    Perfect,
    /// Indicates that the sum of the number's proper divisors is less than the number itself.
    Deficient,
}

/// Classifies a given number based on its aliquot sum.
///
/// An aliquot sum is the sum of all proper divisors of a number (divisors excluding the number itself).
///
/// # Arguments
///
/// * `num` - The number to classify.
///
/// # Returns
///
/// * `Some(Classification)` - The classification of the number if `num` is not zero.
/// * `None` - If `num` is zero, as the concept of proper divisors and aliquot sum does not apply.
pub fn classify(num: u64) -> Option<Classification> {
    if num == 0 {
        return None;
    }

    match aliquote_sum(num) {
        sum if sum > num => Some(Classification::Abundant),
        sum if sum < num => Some(Classification::Deficient),
        _sum => Some(Classification::Perfect),
    }
}

/// Calculates the aliquot sum of a given number.
///
/// The aliquot sum is the sum of all proper divisors of `num` (divisors excluding `num` itself).
///
/// # Arguments
///
/// * `num` - The number for which to calculate the aliquot sum.
///
/// # Returns
///
/// * `u64` - The aliquot sum of `num`. Returns 0 if `num` has no proper divisors (e.g., 1).
fn aliquote_sum(num: u64) -> u64 {
    (1..num)
        .filter(|d| num % d == 0)
        .reduce(|acc, v| acc + v)
        .unwrap_or(0)
}