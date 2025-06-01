mod marker;
mod sieve;

/// Returns a vector containing all prime numbers less than or equal
/// to upper_bound. This list is obtained using the segmented version
/// of the Sieve of Erastotenes.
pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    sieve::Sieve::just_get_primes(upper_bound)
}
