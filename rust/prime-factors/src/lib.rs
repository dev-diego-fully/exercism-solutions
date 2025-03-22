/// Returns a list containing the factorization of the given number by prime numbers.
pub fn factors(n: u64) -> Vec<u64> {
    let mut current = n;
    candidates(n + 1)
        .map_while(|candidate| {
            if current > 1 {
                let times;
                (times, current) = factorate(current, candidate, None);
                Some(vec![candidate; times as usize])
            } else {
                None
            }
        })
        .flatten()
        .collect()
}

/// Returns an iterator with numbers useful for factorization.
fn candidates(limit: u64) -> impl Iterator<Item = u64> {
    std::iter::once(2).chain((3..limit).step_by(2))
}

/// Returns a tuple containing how many times the given number can be
/// divided by the given factor and the resulting value at the end of
/// these divisions. Calculates this recursively and uses 0 as the
/// default value for previous (which serves as a count of how many
/// times the number has been divided so far).
fn factorate(number: u64, factor: u64, previous: Option<u64>) -> (u64, u64) {
    match previous {
        None => factorate(number, factor, Some(0)),
        Some(v) if number % factor == 0 => factorate(number / factor, factor, Some(v + 1)),
        Some(v) => (v, number),
    }
}
