use std::collections::HashSet;

/// Checks whether the given sentence is a pangram (has all letters of
/// the alphabet) or not. Only works for standard Latin alphabet.
pub fn is_pangram(sentence: &str) -> bool {
    sentence.chars().any(alphabet_tracker())
}

/// Returns a closure that checks whether or not a letter has already
/// been passed to it.
fn alphabet_tracker() -> impl FnMut(char) -> bool {
    const ALPHABET_SIZE: usize = 26;
    let mut set: HashSet<char> = HashSet::new();

    move |c: char| {
        if c.is_ascii_alphabetic() {
            set.insert(c.to_ascii_lowercase());
        }
        set.len() >= ALPHABET_SIZE
    }
}
