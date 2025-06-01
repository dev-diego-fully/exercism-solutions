/// Smallest known prime number. That is, the first when in ascending order.
pub(crate) const FIRST_PRIME: u32 = 2;

/// Returns an estimate of what the nth prime number is.
///
/// This estimate purposely always overestimates the nth prime, especially
/// for primes greater than 6.
///
/// Useful to avoid excessive work when finding the nth prime.
pub(crate) fn estimated_nth_prime(n: usize) -> u32 {
    if n < 5 {
        return (2 + 2 * n + 1) as u32;
    }
    let r_n = (n + 1) as f32;
    let ln_n = r_n.ln();
    let estimative = r_n * (ln_n + ln_n.ln());
    estimative.ceil() as u32
}
