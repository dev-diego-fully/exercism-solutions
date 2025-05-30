pub fn recite(start_bottles: u32, take_down: u32) -> String {
    bottles_count_evolution(start_bottles, take_down)
        .map(verse_for)
        .collect::<Vec<String>>()
        .join("\n\n")
}

fn bottles_hanging_on_the_wall(current_bottles: u32) -> String {
    let (quantity, word) = pair_for(current_bottles);
    let quantity = capitalized(quantity);

    format!(
        "{quantity} green {word} hanging on the wall,\n{quantity} green {word} hanging on the wall"
    )
}

fn if_one_acidentally_fall(current_bottles: u32) -> String {
    let (quantity, word) = pair_for(current_bottles);

    format!(
        "And if one green bottle should accidentally fall,\nThere'll be {quantity} green {word} hanging on the wall."
    )
}

fn verse_for(current_bottles: u32) -> String {
    let hanging_on_the_wall = bottles_hanging_on_the_wall(current_bottles);
    let if_one_fall = if_one_acidentally_fall(current_bottles - 1);

    format!("{hanging_on_the_wall},\n{if_one_fall}")
}

fn pair_for<'word>(bottles: u32) -> (&'word str, &'word str) {
    let quantity = word_for(bottles);

    if bottles == 1 {
        (quantity, "bottle")
    } else {
        (quantity, "bottles")
    }
}

fn word_for<'word>(quantity: u32) -> &'word str {
    match quantity {
        0 => "no",
        1 => "one",
        2 => "two",
        3 => "three",
        4 => "four",
        5 => "five",
        6 => "six",
        7 => "seven",
        8 => "eight",
        9 => "nine",
        10 => "ten",
        _ => "OVERFLOWED",
    }
}

fn capitalized(word: &str) -> String {
    if word.is_empty() {
        return String::from(word);
    }
    let first = match word.chars().next() {
        Some(chr) => chr.to_ascii_uppercase(),
        None => return String::from(word),
    };
    std::iter::once(first).chain(word.chars().skip(1)).collect()
}

fn bottles_count_evolution(starting: u32, take_down: u32) -> impl Iterator<Item = u32> {
    (1..=starting).rev().take(take_down as usize)
}
