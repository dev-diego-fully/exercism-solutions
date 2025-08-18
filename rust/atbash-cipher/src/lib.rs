/// Encodes a given plaintext string using the Atbash cipher.
///
/// This function normalizes the input by keeping only alphanumeric characters and converting them
/// to lowercase. It then translates each character and inserts a space every 5 characters
/// to format the final encoded string.
pub fn encode(plain: &str) -> String {
    const ATBASH_SPACE_INTERVAL: usize = 5;

    insert_every(
        plain
            .chars()
            .filter(char::is_ascii_alphanumeric)
            .map(|chr| chr.to_ascii_lowercase())
            .map(translate),
        ATBASH_SPACE_INTERVAL,
        ' ',
    )
}

/// Decodes an Atbash cipher text back to its original plaintext.
///
/// The function first normalizes the input by filtering out any non-alphanumeric characters,
/// then translates each character back to its original form, and collects the results into a new string.
pub fn decode(cipher: &str) -> String {
    cipher
        .chars()
        .filter(char::is_ascii_alphanumeric)
        .map(translate)
        .collect()
}

/// Translates a single character according to the Atbash cipher.
///
/// Digits are returned unchanged. For lowercase letters, it calculates the mirrored character
/// (e.g., 'a' becomes 'z', 'b' becomes 'y', etc.).
fn translate(chr: char) -> char {
    if chr.is_ascii_digit() {
        return chr;
    }
    const CASE_START: u32 = 'a' as u32;
    const ALPHABET_SIZE: u32 = 26;

    let index = chr as u32 - CASE_START;
    let next_index = (ALPHABET_SIZE - index - 1) % ALPHABET_SIZE;
    let next_code = CASE_START + next_index;

    char::from_u32(next_code).unwrap()
}

/// A helper function to insert a specific character at a regular interval.
///
/// It takes an iterator over characters and returns a new `String` with the specified
/// character inserted every `interval` characters.
fn insert_every(string: impl Iterator<Item = char>, interval: usize, inserted: char) -> String {
    let mut result = String::new();

    for (cicle, c) in string.enumerate() {
        if !result.is_empty() && cicle % interval == 0 {
            result.push(inserted);
        }
        result.push(c);
    }

    result
}
