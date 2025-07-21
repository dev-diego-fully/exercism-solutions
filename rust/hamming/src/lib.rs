//! This module provides functionality to calculate the Hamming distance between two strings.

/// Calculates the Hamming distance between two string slices.
///
/// The Hamming distance between two strings of equal length is the number of positions
/// at which the corresponding symbols are different. If the strings have different lengths,
/// the Hamming distance cannot be calculated, and `None` is returned.
///
/// # Arguments
///
/// * `s1` - The first string slice.
/// * `s2` - The second string slice.
///
/// # Returns
///
/// * `Some(usize)` - The Hamming distance if `s1` and `s2` have the same length.
/// * `None` - If `s1` and `s2` have different lengths.
pub fn hamming_distance(s1: &str, s2: &str) -> Option<usize> {
    if s1.len() != s2.len() {
        None
    } else {
        Some(str_differences(s1, s2))
    }
}

/// Creates an iterator that yields pairs of characters from two string slices.
///
/// This function zips the characters of `s1` and `s2` together, effectively
/// pairing characters at the same position.
///
/// # Arguments
///
/// * `s1` - The first string slice.
/// * `s2` - The second string slice.
///
/// # Returns
///
/// An iterator yielding tuples of `(char, char)`, where each tuple contains
/// corresponding characters from `s1` and `s2`.
fn str_paired(s1: &str, s2: &str) -> impl Iterator<Item = (char, char)> {
    s1.chars().zip(s2.chars())
}

/// Counts the number of differing characters between two string slices of the same length.
///
/// This is a helper function used internally by `hamming_distance` when string lengths match.
/// It iterates through character pairs and counts where they are not equal.
///
/// # Arguments
///
/// * `s1` - The first string slice.
/// * `s2` - The second string slice.
///
/// # Returns
///
/// The number of positions where characters in `s1` and `s2` differ.
fn str_differences(s1: &str, s2: &str) -> usize {
    str_paired(s1, s2).filter(|(a, b)| a != b).count()
}