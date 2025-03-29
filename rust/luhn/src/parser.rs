/// Tries to return the digits of the passed luhn code. Returns None
/// if the code is not minimally valid (has invalid characters,
/// is not long enough), otherwise, returns a Some containing the digits.
pub(crate) fn get_digits(code: &str) -> Option<impl DoubleEndedIterator<Item = u8> + Clone + '_> {
    if !has_only_valid_chars(code) {
        return None;
    }
    let digits= code
        .bytes()
        .filter_map(parse_digit);

    if digits.clone().count() <= 1 {
        return None;
    }

    Some(digits)
}

/// Checks if the provided luhn code contains only valid characters
/// (only digits and blank spaces).
fn has_only_valid_chars(code: &str) -> bool {
    code.chars().all(is_valid_char)
}

/// Checks if the given character is valid in a luhn code.
fn is_valid_char(chr: char) -> bool {
    match chr {
        ' ' => true,
        c => c.is_ascii_digit(),
    }
}

/// If the given character is a digit, it returns a Some
/// containing it, otherwise it returns a None.
fn parse_digit(chr: u8) -> Option<u8> {
    match chr {
        c if c.is_ascii_digit() => Some(c - b'0'),
        _ => None,
    }
}
