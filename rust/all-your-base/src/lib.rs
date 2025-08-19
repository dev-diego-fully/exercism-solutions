///
/// Convert a number between two bases.
///
/// A number is any slice of digits.
/// A digit is any unsigned integer (e.g. u8, u16, u32, u64, or usize).
/// Bases are specified as unsigned integers.
///
/// Return the corresponding Error enum if the conversion is impossible.
///
///
/// You are allowed to change the function signature as long as all test still pass.
///
///
/// Example:
/// Input
///   number: &[4, 2]
///   from_base: 10
///   to_base: 2
/// Result
///   Ok(vec![1, 0, 1, 0, 1, 0])
///
/// The example corresponds to converting the number 42 from decimal
/// which is equivalent to 101010 in binary.
///
///
/// Notes:
///  * The empty slice ( "[]" ) is equal to the number 0.
///  * Never output leading 0 digits, unless the input number is 0, in which the output must be `[0]`.
///
pub fn convert(number: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, Error> {
    validate_digits_and_bases(number, from_base, to_base)?;

    if from_base == to_base {
        return Ok(number.to_vec());
    }

    Ok(from_value(to_value(number, from_base), to_base))
}

/// An enumeration of possible errors during a base conversion.
///
/// This enum represents specific failure cases:
/// * `InvalidInputBase`: The input base is less than 2.
/// * `InvalidOutputBase`: The output base is less than 2.
/// * `InvalidDigit(u32)`: A digit in the number is greater than or equal to the input base.
#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

/// Validates the input number's digits and the specified bases.
///
/// The function checks if the `from_base` and `to_base` are valid (greater than or equal to 2).
/// It also ensures that all digits in the `number` slice are less than the `from_base`.
fn validate_digits_and_bases(number: &[u32], from_base: u32, to_base: u32) -> Result<(), Error> {
    if from_base < 2 {
        return Err(Error::InvalidInputBase);
    }
    if to_base < 2 {
        return Err(Error::InvalidOutputBase);
    }
    match number.iter().find(|&&d| d >= from_base) {
        Some(&d) => Err(Error::InvalidDigit(d)),
        None => Ok(()),
    }
}

/// Converts a number from a base-specific digit representation to its base-10 value.
///
/// The function iterates over the digits from right to left, calculating the decimal value
/// by summing the products of each digit and its corresponding power of the input base.
fn to_value(digits: &[u32], input_base: u32) -> u32 {
    digits
        .iter()
        .rev()
        .enumerate()
        .map(|(i, &d)| d * input_base.pow(i as u32))
        .sum()
}

/// Converts a base-10 value to its digit representation in a new base.
///
/// The function repeatedly calculates the remainder and quotient of the value divided
/// by the output base, which generates the digits in reverse order. The result is then
/// reversed to produce the correct digit sequence.
fn from_value(value: u32, output_base: u32) -> Vec<u32> {
    if value == 0 {
        return vec![0];
    }
    let mut current = value;
    let mut result = Vec::new();

    while current > 0 {
        result.push(current % output_base);
        current /= output_base;
    }

    result.into_iter().rev().collect()
}