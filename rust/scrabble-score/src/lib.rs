/// Calculates the Scrabble score of a given word.
///
/// The function processes the input string by iterating over its characters,
/// filtering out non-ASCII characters, converting all characters to uppercase,
/// and then summing the score of each character.
///
/// # Arguments
///
/// * `word` - A string slice (`&str`) representing the word to be scored.
///
/// # Returns
///
/// The total Scrabble score of the word as a `u64` unsigned integer.
pub fn score(word: &str) -> u64 {
    word.chars()
        .filter(char::is_ascii)
        .flat_map(char::to_uppercase)
        .map(char_score)
        .sum()
}

/// Returns the Scrabble score for a single uppercase character.
///
/// The score is determined by a `match` expression that maps specific
/// characters to their corresponding point values.
///
/// # Arguments
///
/// * `chr` - An uppercase character (`char`) to be scored.
///
/// # Returns
///
/// The Scrabble point value of the character as a `u64` unsigned integer.
fn char_score(chr: char) -> u64 {
    match chr {
        'A' | 'E' | 'I' | 'O' | 'U' | 'L' | 'N' | 'R' | 'S' | 'T' => 1,
        'D' | 'G' => 2,
        'B' | 'C' | 'M' | 'P' => 3,
        'F' | 'H' | 'V' | 'W' | 'Y' => 4,
        'K' => 5,
        'J' | 'X' => 8,
        'Q' | 'Z' => 10,
        _ => 0,
    }
}
