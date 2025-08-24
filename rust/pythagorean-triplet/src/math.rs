//! This module contains mathematical utility functions used throughout the crate.
//!
//! Functions include finding divisors, multiplying triplets, and a safe integer square root.
use crate::Triplet;

/// Multiplies each element of a triplet by a given multiplier.
///
/// This is used to scale a primitive triplet to find a non-primitive one.
pub(crate) fn multiply_triplet([a, b, c]: Triplet, mult: u32) -> Triplet {
    [a * mult, b * mult, c * mult]
}

/// Generates an iterator over all divisors of a given number `n`, from 1 up to `n/2`.
pub(crate) fn divisors_of(n: u32) -> impl Iterator<Item = u32> {
    (1..=n / 2).filter(move |d| n % d == 0)
}

/// Calculates the integer square root of a `u32` number.
///
/// It uses floating-point conversion for the square root calculation and then
/// truncates the result to a `u32`.
pub(crate) fn u32_sqrt(n: u32) -> u32 {
    (n as f32).sqrt() as u32
}