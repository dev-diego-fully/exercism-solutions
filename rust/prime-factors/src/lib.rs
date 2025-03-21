/// Returns a list containing the factorization of the given number by prime numbers.
pub fn factors(n: u64) -> Vec<u64> {
    let mut current = n;
    let mut factors = Vec::new();

    for candidate in candidates(n + 1) {
        if current == 1 {
            break;
        }
        while current % candidate == 0 {
            factors.push(candidate);
            current /= candidate;
        }
    }

    factors
}

/// Returns an iterator with numbers useful for factorization.
fn candidates(limit: u64) -> impl Iterator<Item = u64> {
    std::iter::once(2).chain((3..limit).step_by(2))
}
