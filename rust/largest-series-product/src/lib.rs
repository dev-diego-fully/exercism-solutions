/// An enumeration of possible errors that can occur during the calculation of the largest
/// series product.
#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    /// Indicates that the requested span is larger than the number of digits in the string.
    SpanTooLong,
    /// Indicates that the input string contains a non-digit character. The character is
    /// included as a variant value.
    InvalidDigit(char),
}

/// Calculates the largest product of a contiguous series of digits of a given length.
///
/// This function first validates the input string and span. If the span is 0, it returns 1.
/// Otherwise, it converts the string into a vector of digits, creates an iterator over all
/// possible windows (slices) of the specified length, maps each window to its product,
/// and finds the maximum product.
///
/// # Arguments
///
/// * `string_digits` - A string slice (`&str`) containing the digits.
/// * `span` - The length of the series to calculate the product for.
///
/// # Returns
///
/// A `Result` containing:
/// * `Ok(u64)` - The largest product as a `u64` if the calculation is successful.
/// * `Err(Error)` - An `Error` variant if the input is invalid.
pub fn lsp(string_digits: &str, span: usize) -> Result<u64, Error> {
    validate_digits_and_span(string_digits, span)?;

    if span == 0 {
        return Ok(1);
    }

    Ok(digits(string_digits)
        .windows(span)
        .map(digits_product)
        .max()
        .unwrap())
}

/// A helper function to validate the input string and span.
///
/// It checks if the `string_digits` is shorter than the `span` or if it contains any non-digit
/// characters.
///
/// # Arguments
///
/// * `string_digits` - The string slice to validate.
/// * `span` - The span length.
///
/// # Returns
///
/// `Ok(())` if the input is valid, or an `Err(Error)` otherwise.
fn validate_digits_and_span(string_digits: &str, span: usize) -> Result<(), Error> {
    if string_digits.len() < span {
        return Err(Error::SpanTooLong);
    }
    match string_digits.chars().find(|chr| !chr.is_ascii_digit()) {
        Some(chr) => Err(Error::InvalidDigit(chr)),
        None => Ok(()),
    }
}

/// Converts a string slice of digits into a `Vec` of `u8` numbers.
///
/// # Arguments
///
/// * `string` - The string slice containing the digits.
///
/// # Returns
///
/// A vector of `u8` where each element is a digit from the input string.
fn digits(string: &str) -> Vec<u8> {
    string
        .chars()
        .map(|chr| chr.to_digit(10).unwrap() as u8)
        .collect()
}

/// Calculates the product of all digits in a slice.
///
/// # Arguments
///
/// * `digits` - A slice of `u8` representing the digits.
///
/// # Returns
///
/// The product of all digits as a `u64`.
fn digits_product(digits: &[u8]) -> u64 {
    digits.iter().fold(1, |acc, &v| acc * (v as u64))
}