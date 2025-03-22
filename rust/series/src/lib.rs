/// Returns all possible subseries of size len for the given string digits.
pub fn series(digits: &str, len: usize) -> Vec<String> {
    if len > digits.len() {
        return vec![];
    }
    let limit = digits.len() - len + 1;
    (0..limit)
        .map(|start| substring(digits, start, len))
        .collect()
}

/// Returns a portion of the given string, according to the given start and length.
fn substring(string: &str, start: usize, len: usize) -> String {
    string.chars().skip(start).take(len).collect()
}
