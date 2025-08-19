/// Determines if a given string is a valid ISBN-10 number.
///
/// This function first attempts to parse the input string into a sequence of 10 digits.
/// If parsing is successful, it calculates the checksum of the digits and validates it.
/// A number is valid if its checksum is divisible by 11.
pub fn is_valid_isbn(isbn: &str) -> bool {
    match parse_isbn(isbn) {
        None => false,
        Some(parsed) => is_valid_check_sum(check_sum(&parsed)),
    }
}

/// The expected length of the ISBN-10 code (10 digits).
const IBSN_CODE_LEN: usize = 10;

/// Parses an ISBN-10 string into a vector of its digits.
///
/// The function processes the input string character by character, converting
/// digits '0' through '9' to `u32` numbers and the character 'X' at the last position
/// to the value 10. Hyphens are ignored. If any invalid character is found, or if
/// the final digit count is not 10, the function returns `None`.
fn parse_isbn(isbn: &str) -> Option<Vec<u32>> {
    let mut digits = Vec::new();

    for c in isbn.chars() {
        match c {
            '0'..='9' if digits.len() < IBSN_CODE_LEN => digits.push(c.to_digit(10).unwrap()),
            'X' if digits.len() == IBSN_CODE_LEN - 1 => digits.push(10),
            '-' => (),
            _ => return None,
        }
    }
    if digits.len() != 10 {
        return None;
    }

    Some(digits)
}

/// Calculates the checksum for a given ISBN-10 number.
///
/// The checksum is a weighted sum where each digit is multiplied by a decreasing
/// weight from 10 down to 1. The result is the sum of these products.
fn check_sum(isbn: &[u32]) -> u32 {
    isbn.iter()
        .enumerate()
        .map(|(i, &d)| d * (10 - i) as u32)
        .sum()
}

/// Determines if a given checksum is valid.
///
/// An ISBN-10 checksum is considered valid if it is a multiple of 11.
fn is_valid_check_sum(sum: u32) -> bool {
    const ISBN_CHECK_MOD: u32 = 11;
    sum % ISBN_CHECK_MOD == 0
}