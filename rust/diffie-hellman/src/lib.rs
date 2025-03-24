/// Generate a random private key using the given prime number.
pub fn private_key(p: u64) -> u64 {
    rand::random_range(2..p)
}

/// Generates a public key from the given primes p and g as well
/// as the given public key and private key.
pub fn public_key(p: u64, g: u64, a: u64) -> u64 {
    mod_pow(g, a, p)
}

/// Generates the secret key from the prime p, using the public key b_pub,
/// and the private key a.
pub fn secret(p: u64, b_pub: u64, a: u64) -> u64 {
    mod_pow(b_pub, a, p)
}

/// Returns the remainder for modulus of value raised to power.
/// Calculates the value recursively and in an optimized manner
/// so as not to overflow the representation for high exponents.
fn mod_pow(value: u64, power: u64, modulus: u64) -> u64 {
    let (left, right) = match power {
        1 => (value, 1),
        p if p % 2 == 1 => {
            let left = mod_pow(value, p / 2, modulus);
            let right = splited_mod(left, value, modulus);
            (left, right)
        }
        p => {
            let new_val = mod_pow(value, p / 2, modulus);
            (new_val, new_val)
        }
    };
    (left * right) % modulus
}

/// Calculates the remainder for modulus of a number given by
/// (a * b)
fn splited_mod(a: u64, b: u64, modulus: u64) -> u64 {
    let a = a as u128;
    let b = b as u128;
    let modulus = modulus as u128;
    let result = (a % modulus * b % modulus) % modulus;
    result as u64
}
