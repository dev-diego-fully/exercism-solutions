mod parser;

/// Checks if the given Luhn code is valid
pub fn is_valid(code: &str) -> bool {
    match parser::get_digits(code) {
        Some(digits) => check_luhn_sum(luhn_sum(digits)),
        None => false,
    }
}

/// Calculate the sum used in checking a Kuhn code for
/// the given digits
fn luhn_sum(digits: impl DoubleEndedIterator<Item = u8> + Clone) -> u64 {
    let doubleds_sum: u64 = digits
        .clone()
        .rev()
        .skip(1)
        .step_by(2)
        .map(double_digit)
        .sum();
    let non_doubleds_sum: u64 = digits
        .rev()
        .step_by(2)
        .map(|x| x as u64)
        .sum();
    doubleds_sum + non_doubleds_sum
}

/// Checks if the given Luhn sum is valid
fn check_luhn_sum(sum: u64) -> bool {
    const LUHM_CHECKER_BASE: u8 = 10;
    sum % LUHM_CHECKER_BASE as u64 == 0
}

/// Returns the given digit doubled, according to the Luhn
/// digit folding operation. Doubles the digit and if the
/// result is greater than 9, subtracts 9 from the result.
/// Otherwise, returns the result normally.
fn double_digit(digit: u8) -> u64 {
    match digit * 2 {
        d if d > 9 => d as u64 - 9,
        d => d as u64,
    }
}
