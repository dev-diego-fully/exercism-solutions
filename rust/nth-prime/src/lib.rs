mod marker;
mod primes_info;
mod sieve;

pub fn nth(n: u32) -> u32 {
    sieve::Sieve::just_get_nth(n as usize)
}

