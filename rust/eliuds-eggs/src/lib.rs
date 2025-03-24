/// Counts the number of eggs considering the number passed as a bitarray
pub fn egg_count(display_value: u32) -> usize {
    count_bin_ones(display_value)
}

/// Counts the number of ones that the binary representation of value has.
fn count_bin_ones(value: u32) -> usize {
    bin_digits(value).filter(|v| *v).count()
}

/// Gets an iterator to the binary representation of value. Uses bools to
/// represent zeros and ones.
fn bin_digits(value: u32) -> impl Iterator<Item = bool> {
    (0..).map_while(move |d| match 1 << d {
        v if v > value => None,
        v => Some(value & v != 0),
    })
}
