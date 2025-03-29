use std::collections::HashSet;

/// Checks whether the given sentence is a pangram (has all letters of
/// the alphabet) or not. Only works for the Latin alphabet.
pub fn is_pangram(sentence: &str) -> bool {
    sentence.chars().any(repeated_letter_checker())
}

/// Returns a closure that checks whether or not a letter has already
/// been passed to it.
fn repeated_letter_checker() -> impl FnMut(char) -> bool {
    const ALPHABET_SIZE: u8 = 26;
    let mut set: HashSet<char> = HashSet::new();

    move |c: char| {
        if c.is_alphabetic() {
            set.insert(c.to_ascii_lowercase());
        }
        set.len() == ALPHABET_SIZE as usize
    }
}
