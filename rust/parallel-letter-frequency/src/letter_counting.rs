//! This module provides functions and types for counting and merging letter frequencies.
//!
//! It defines the `CharCounter` type alias and contains the core logic for counting
//! letters in a single string and merging multiple counters together.
use std::collections::HashMap;

/// A type alias for a HashMap that maps a character to its frequency count.
pub(crate) type CharCounter = HashMap<char, usize>;

/// Counts the frequency of alphabetic characters in a given string.
///
/// The function processes the string, filters for alphabetic characters, converts
/// them to lowercase, and then uses a fold operation to populate a `CharCounter` map.
pub(crate) fn count_letter_frequency(string: String) -> CharCounter {
    string
        .chars()
        .filter(|arg0: &char| char::is_alphabetic(*arg0))
        .map(|chr: char| char::to_ascii_lowercase(&chr))
        .fold(HashMap::new(), increment_letter_count)
}

/// Merges an `updates` counter into an `original` counter.
///
/// The function takes a new counter with updates and folds them into the original counter,
/// summing the counts for each character.
pub(crate) fn merge_counters(original: CharCounter, updates: CharCounter) -> HashMap<char, usize> {
    updates.into_iter().fold(original, update_letter_count)
}

/// A helper function to increment the count for a single character in a counter.
///
/// This function is designed to be used with the `fold` method to build a counter
/// from an iterator of characters.
fn increment_letter_count(mut counter: CharCounter, incremented: char) -> CharCounter {
    let original_count = counter.get(&incremented).cloned().unwrap_or(0);
    let next_count = original_count + 1;

    counter.insert(incremented, next_count);
    counter
}

/// A helper function to update a counter with counts from another counter.
///
/// This function is designed to be used with the `fold` method to merge counters.
fn update_letter_count(mut counter: CharCounter, (updated, count): (char, usize)) -> CharCounter {
    let original_count = counter.get(&updated).cloned().unwrap_or(0);
    let next_count = original_count + count;

    counter.insert(updated, next_count);
    counter
}