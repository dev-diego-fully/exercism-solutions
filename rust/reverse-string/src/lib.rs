use unicode_segmentation::UnicodeSegmentation;

/// Reverses the given string. Takes static string (&str) and returns it as String.
pub fn reverse(input: &str) -> String {
    input.graphemes(true).rev().collect()
}
