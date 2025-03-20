/// Returns true if the given number is an Armstrong number.
/// An Armstrong number is one in which the sum of each digit raised
/// to the number of digits in the number is equal to the number itself.
pub fn is_armstrong_number(num: u32) -> bool {
    armstrong_sum(num) == num
}

/// Returns the sum of each digit of the given number, raised to the number
/// of digits in the given number.
fn armstrong_sum(num: u32) -> u32 {
    let digits = get_digits(num);
    let exp = digits.len() as u32;
    digits.iter().map(|digit| (*digit as u32).pow(exp)).sum()
}

/// Returns a Vector containing the digits of the passed number.
/// Each digit is treated as a u8 to save memory.
fn get_digits(num: u32) -> Vec<u8> {
    let base: u32 = 10;
    let mut digits = Vec::<u8>::new();
    let mut current = num;

    while current > 0 {
        digits.push((current % base) as u8);
        current /= base;
    }

    digits.reverse();
    digits
}
