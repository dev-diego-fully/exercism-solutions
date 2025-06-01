mod marker;
mod primes_info;
mod sieve;

/// Returns the nth prime number.
/// 
/// Counting starts at 0, as is the language convention.
pub fn nth(n: u32) -> u32 {
    sieve::Sieve::just_get_nth(n as usize)
}

