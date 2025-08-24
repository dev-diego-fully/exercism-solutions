//! This module contains the primary logic for finding Pythagorean triplets whose sum equals a given value.
//!
//! The approach is based on Euclid's formula, which generates primitive triplets. The code
//! then uses divisors of the target sum to find all non-primitive triplets as well.
mod euclides_duplets;
mod math;

use std::collections::HashSet;

/// A type alias for a tuple of three `u32` integers, representing a Pythagorean triplet.
type Triplet = [u32; 3];

/// Finds all unique Pythagorean triplets (a, b, c) where a + b + c = `sum`.
///
/// The function first finds all divisors of the `sum`. For each divisor, it searches
/// for primitive Pythagorean triplets whose sum, when multiplied by the divisor,
/// matches the original `sum`.
pub fn find(sum: u32) -> HashSet<Triplet> {
    math::divisors_of(sum)
        .flat_map(|divisor| triplets_for_divisor(sum, divisor))
        .collect()
}

/// Generates an iterator of triplets that can be scaled by a `divisor` to match the `sum`.
///
/// It finds the primitive triplets whose sum equals `sum / divisor` and then
/// multiplies each of those triplets by the `divisor`.
fn triplets_for_divisor(sum: u32, divisor: u32) -> impl Iterator<Item = Triplet> {
    primitive_triplets(sum / divisor).map(move |t| math::multiply_triplet(t, divisor))
}

/// Generates an iterator of all primitive Pythagorean triplets whose sum is a given value.
///
/// This function relies on the `euclides_duplets` module to find the generating pairs `(k, m)`
/// and convert them into the final triplets.
fn primitive_triplets(sum: u32) -> impl Iterator<Item = Triplet> {
    euclides_duplets::for_pythagorean_sum(sum).map(euclides_duplets::to_pythagorean_triplet)
}