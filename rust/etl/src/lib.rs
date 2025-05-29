use std::collections::BTreeMap;

pub fn transform(h: &BTreeMap<i32, Vec<char>>) -> BTreeMap<char, i32> {
    h.iter().flat_map(transformate_for).collect()
}

fn transformate_for((score, letters): (&i32, &Vec<char>)) -> impl Iterator<Item = (char, i32)> {
    letters
        .iter()
        .map(move |letter| ((*letter).to_ascii_lowercase(), *score))
}
