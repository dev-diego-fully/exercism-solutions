use std::collections::HashSet;

/// Determines whether a string is an isogram, which is a word or phrase without a repeating letter.
///
/// The check is case-insensitive and ignores non-alphabetic characters. It works by normalizing
/// the input string and then iterating through the characters, inserting each one into a `HashSet`.
/// If `insert` returns `false` at any point, it means a duplicate character was found.
///
/// # Arguments
///
/// * `candidate` - The string slice (`&str`) to be checked.
///
/// # Returns
///
/// `true` if the string is an isogram, `false` otherwise.
pub fn check(candidate: &str) -> bool {
    let mut seens = HashSet::new();
    normalized(candidate).all(|c| seens.insert(c))
}

/// A helper function that normalizes a string for isogram checking.
///
/// It filters out all non-alphabetic ASCII characters and converts the remaining letters
/// to lowercase. The function returns an iterator for efficient, lazy processing.
///
/// # Arguments
///
/// * `candidate` - The string slice (`&str`) to normalize.
///
/// # Returns
///
/// An iterator that yields the normalized characters.
fn normalized(candidate: &str) -> impl Iterator<Item = char> {
    candidate
        .chars()
        .filter(char::is_ascii_alphabetic)
        .map(|letter: char| char::to_ascii_lowercase(&letter))
}