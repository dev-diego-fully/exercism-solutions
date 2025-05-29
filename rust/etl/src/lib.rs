use std::collections::BTreeMap;

pub fn transform(h: &BTreeMap<i32, Vec<char>>) -> BTreeMap<char, i32> {
    h.iter()
        .flat_map(|(score, letters)| transformate_for(score, letters))
        .collect()
}

fn transformate_for(score: &i32, letters: &[char]) -> impl Iterator<Item = (char, i32)> {
    letters
        .iter()
        .map(move |letter| ((*letter).to_ascii_lowercase(), *score))
}
