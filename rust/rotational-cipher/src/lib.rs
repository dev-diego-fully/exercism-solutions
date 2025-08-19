/// Encodes or decodes a string using the Caesar cipher.
///
/// This function applies a rotation to each character of the input string based on a given key.
/// It works by getting a rotator closure and applying it to each character, then collecting the
/// results into a new `String`.
pub fn rotate(input: &str, key: u8) -> String {
    input.chars().map(rotator(key)).collect()
}

/// A helper function that returns a closure to rotate a single character.
///
/// The returned closure takes a `char` as input and returns a new `char`. It applies the rotation
/// only to alphabetic characters (both uppercase and lowercase), while leaving other characters
/// unchanged.
fn rotator(key: u8) -> impl Fn(char) -> char {
    move |chr: char| {
        if chr.is_ascii_uppercase() {
            rotate_uppercase(chr, key)
        } else if chr.is_ascii_lowercase() {
            rotate_lowercase(chr, key)
        } else {
            chr
        }
    }
}

/// The number of letters in the English alphabet.
const ALPHABET_LEN: u32 = 26;

/// Rotates an uppercase character by a given key.
///
/// The function calculates the new position of the character in the alphabet and handles
/// wrap-around using modulo arithmetic.
fn rotate_uppercase(chr: char, key: u8) -> char {
    const CASE_START: u32 = 'A' as u32;

    let index = chr as u32 - CASE_START;
    let next_index = (index + key as u32) % ALPHABET_LEN;

    char::from_u32(CASE_START + next_index).unwrap()
}

/// Rotates a lowercase character by a given key.
///
/// The function calculates the new position of the character in the alphabet and handles
/// wrap-around using modulo arithmetic, similar to `rotate_uppercase`.
fn rotate_lowercase(chr: char, key: u8) -> char {
    const CASE_START: u32 = 'a' as u32;

    let index = chr as u32 - CASE_START;
    let next_index = (index + key as u32) % ALPHABET_LEN;

    char::from_u32(CASE_START + next_index).unwrap()
}