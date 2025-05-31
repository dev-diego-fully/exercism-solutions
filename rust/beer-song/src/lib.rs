/// Returns the version of "Beer Song" for the given number of beer bottles
/// remaining at the start of the verse.
pub fn verse(bottles: u32) -> String {
    format!(
        "{}\n{}",
        bottles_on_the_wall_line(bottles),
        action_line(bottles)
    )
}

/// Returns a "singing" of the verses between start and end (inclusive).
pub fn sing(start: u32, end: u32) -> String {
    bottles_count_evolution(start, end)
        .map(verse)
        .collect::<Vec<String>>()
        .join("\n\n")
}

/// Returns an iterator containing the evolution of the number of beer
/// bottles remaining at the start of the verse, for the verses between
/// start and end (inclusive).
fn bottles_count_evolution(start: u32, end: u32) -> impl Iterator<Item = u32> {
    (end..=start).rev()
}

/// Returns the first part of the verse for the number of bottles given.
/// This first part is the one that tells how many bottles of beer there
/// are at the moment.
fn bottles_on_the_wall_line(bottles: u32) -> String {
    match bottles {
        0 => String::from("No more bottles of beer on the wall, no more bottles of beer."),
        1 => String::from("1 bottle of beer on the wall, 1 bottle of beer."),
        _ => format!("{bottles} bottles of beer on the wall, {bottles} bottles of beer."),
    }
}

/// Returns the second part of a verse of the "Beer Song", according to the
/// number of bottles present at the beginning of the verse.
fn action_line(bottles: u32) -> String {
    if bottles == 0 {
        String::from(GO_AND_BUY)
    } else {
        take_one_down_line(bottles - 1)
    }
}

/// Returns the "line" from the "take down one" action for the amount of
/// bottles left after the action.
fn take_one_down_line(remaining: u32) -> String {
    match remaining {
        0 => String::from("Take it down and pass it around, no more bottles of beer on the wall."),
        1 => String::from("Take one down and pass it around, 1 bottle of beer on the wall."),
        _ => format!("Take one down and pass it around, {remaining} bottles of beer on the wall."),
    }
}

/// Line from the second part of the verse of the "Beer Song", for when
/// there are no more bottles left (you need to buy more).
const GO_AND_BUY: &str = "Go to the store and buy some more, 99 bottles of beer on the wall.";
