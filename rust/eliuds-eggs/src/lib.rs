/// Counts the number of eggs considering the number passed as a bitarray
pub fn egg_count(display_value: u32) -> usize {
    display_value.count_ones() as usize
}
