/// Returns a string containing each verse recited starting at `start_bottles`
/// and ending after "take" a bottle `take_down` times.
pub fn recite(start_bottles: u32, take_down: u32) -> String {
    bottles_count_evolution(start_bottles, take_down)
        .map(verse_for)
        .collect::<Vec<String>>()
        .join("\n\n")
}

/// Returns the first part of a verse from the "Green Bottle Song" for the
/// number of bottles remaining. This first part is the one that tells how
/// many bottles are still "hanging in the wall".
fn bottles_hanging_on_the_wall(current_bottles: u32) -> String {
    let (quantity, word) = pair_for(current_bottles);
    let quantity = capitalized(quantity);

    format!(
        "{quantity} green {word} hanging on the wall,\n{quantity} green {word} hanging on the wall"
    )
}

/// Returns the second part of a verse from the "Green Bottle Song" to the
/// number of bottles remaining at the beginning of the verse. This second
/// part is the one that tells what would happen if one of the bottles
/// "accidentally fell over".
fn if_one_acidentally_fall(current_bottles: u32) -> String {
    let (quantity, word) = pair_for(current_bottles);

    format!(
        "And if one green bottle should accidentally fall,\nThere'll be {quantity} green {word} hanging on the wall."
    )
}

/// Returns a complete verse when there are `current bottles` "hanging on
/// the wall" at the beginning of the verse.
fn verse_for(current_bottles: u32) -> String {
    let hanging_on_the_wall = bottles_hanging_on_the_wall(current_bottles);
    let if_one_fall = if_one_acidentally_fall(current_bottles - 1);

    format!("{hanging_on_the_wall},\n{if_one_fall}")
}

/// Given a quantity of bottles `bottles`, returns a tuple containing how
/// to say this quantity and the word used ("bottle" or "bottles") depending
/// on whether a plural is needed or not.
fn pair_for<'word>(bottles: u32) -> (&'word str, &'word str) {
    let quantity = writed_quantity(bottles);

    if bottles == 1 {
        (quantity, "bottle")
    } else {
        (quantity, "bottles")
    }
}

/// Returns the quantity provided in full. If the quantity is greater
/// than 10, it returns "OVERFLOWED" indicating that the maximum quantity
/// of bottles in the song has been exceeded.
fn writed_quantity<'word>(quantity: u32) -> &'word str {
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

/// Returns a copy of the given word, but capitalized (i.e. with the first
/// letter in upper case).
fn capitalized(word: &str) -> String {
    if word.is_empty() {
        return String::new();
    }
    let first = match word.chars().next() {
        Some(chr) => chr.to_ascii_uppercase(),
        None => return String::from(word),
    };
    std::iter::once(first).chain(word.chars().skip(1)).collect()
}

/// Returns an iterator containing the evolution of the number of bottles
/// "hanging on the wall" according to the initial number and the number of
/// times a bottle "accidentally falls".
fn bottles_count_evolution(starting: u32, take_down: u32) -> impl Iterator<Item = u32> {
    (1..=starting).rev().take(take_down as usize)
}
