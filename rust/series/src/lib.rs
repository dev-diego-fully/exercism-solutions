/// Returns all possible subseries of size len for the given string digits.
pub fn series(digits: &str, len: usize) -> Vec<String> {
    if len > digits.len() {
        return vec![];
    }
    string_to_char_vector(digits)
        .windows(len)
        .map(char_vector_to_string)
        .collect()
}

/// Returns a string (&str) transformed into a vector of characters (Vec<char>).
fn string_to_char_vector(string: &str) -> Vec<char> {
    string.chars().collect::<Vec<char>>()
}

/// Returns a vector of characters ([char]), transformed into a string (String).
fn char_vector_to_string(vec: &[char]) -> String {
    vec.iter().collect::<String>()
}
