use std::collections::BTreeMap;

/// Returns a version of the map `h` in which instead of mapping a
/// punctuation mark to an array of uppercase letters, it maps a lowercase
/// letter to a direct punctuation mark. During the transformation process,
/// it changes the case normally.
pub fn transform(h: &BTreeMap<i32, Vec<char>>) -> BTreeMap<char, i32> {
    h.iter().flat_map(transformate_for).collect()
}

/// Transforms a map entry, in the input format, into an iterator of the
/// output map entries.
/// Handles case-changing of the two formats.
/// 
/// The input format maps a score to an array of letters that have that score.
/// 
/// The output format maps a letter to its score in the game.
fn transformate_for((score, letters): (&i32, &Vec<char>)) -> impl Iterator<Item = (char, i32)> {
    letters
        .iter()
        .map(move |letter| ((*letter).to_ascii_lowercase(), *score))
}
