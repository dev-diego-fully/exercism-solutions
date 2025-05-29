pub(crate) const FIRST_PRIME: u32 = 2;

pub(crate) fn estimated_nth_prime(n: usize) -> u32 {
    if n < 5 {
        return (2 + 2 * n + 1) as u32;
    }
    let r_n = (n + 1) as f32;
    let ln_n = r_n.ln();
    let estimative = r_n * (ln_n + ln_n.ln());
    estimative.ceil() as u32
}
