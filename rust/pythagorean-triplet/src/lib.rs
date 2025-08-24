use std::collections::HashSet;

/// A type alias for a tuple of three `u32` integers, representing a Pythagorean triplet.
type Triplet = [u32; 3];

/// Finds all unique Pythagorean triplets (a, b, c) where a + b + c = `sum`.
///
/// The function generates all possible triplets for the given `sum` and then
/// filters them to keep only those that satisfy the Pythagorean theorem.
/// It returns a `HashSet` to ensure that only unique triplets are included.
pub fn find(sum: u32) -> HashSet<Triplet> {
    triplets(sum).filter(is_pythagorean).collect()
}

/// Checks if a given triplet is a Pythagorean triplet.
///
/// The function returns `true` if the square of the first two elements
/// sums to the square of the third element (`a² + b² = c²`).
fn is_pythagorean([a, b, c]: &Triplet) -> bool {
    a.pow(2) + b.pow(2) == c.pow(2)
}

/// Generates an iterator over all possible `Triplet` candidates for a given sum.
///
/// The function iterates through possible values for `a`, from 1 up to `sum / 3`,
/// and uses `flat_map` to generate all potential triplets for each `a`.
fn triplets(sum: u32) -> impl Iterator<Item = Triplet> {
    (1..sum / 3).flat_map(move |a| triplets_with_a(sum, a))
}

/// Generates an iterator over all possible `Triplet` candidates for a specific `a`.
///
/// The function iterates through possible values for `b`, from `a + 1` up to `(sum - a) / 2`.
/// This range ensures that `b` is greater than `a` and that `c` will be greater than `b`.
fn triplets_with_a(sum: u32, a: u32) -> impl Iterator<Item = Triplet> {
    (a + 1..=(sum - a) / 2).map(move |b| triplet_with_a_and_b(sum, a, b))
}

/// Creates a `Triplet` given `sum`, `a`, and `b`.
///
/// The third element `c` is calculated as `sum - a - b`.
fn triplet_with_a_and_b(sum: u32, a: u32, b: u32) -> Triplet {
    [a, b, sum - a - b]
}