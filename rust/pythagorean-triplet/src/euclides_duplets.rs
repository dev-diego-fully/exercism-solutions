//! This module implements logic related to Euclid's formula for generating Pythagorean triplets.
//!
//! It finds integer pairs `(k, m)` that can be used to generate a Pythagorean triplet
//! with a specific sum.
use crate::{math, Triplet};

/// A type alias for a pair of `u32` integers used in Euclid's formula.
pub(crate) type Duplet = [u32; 2];

/// Generates an iterator over all `Duplet` pairs `(k, m)` that satisfy the conditions
/// of Euclid's formula for a given sum.
///
/// The formula `2m(m+k) = sum` is used to find the correct pairs. The search space
/// for `m` is limited by the square root of the sum, and `k` is less than `m`.
pub(crate) fn for_pythagorean_sum(sum: u32) -> impl Iterator<Item = Duplet> {
    (1..=math::u32_sqrt(sum))
        .flat_map(move |m| (1..m).map(move |k| [k, m]))
        .filter(move |[k, m]| 2 * m * (m + k) == sum)
}

/// Converts a `Duplet` pair `(k, m)` into a Pythagorean triplet.
///
/// The triplet is calculated using Euclid's formula:
/// `a = m² - k²`, `b = 2mk`, `c = m² + k²`.
/// The resulting triplet is sorted to ensure a consistent output order (`a < b < c`).
pub(crate) fn to_pythagorean_triplet([k, m]: Duplet) -> Triplet {
    let mut triplet = [m.pow(2) - k.pow(2), 2 * m * k, m.pow(2) + k.pow(2)];
    triplet.sort();
    triplet
}