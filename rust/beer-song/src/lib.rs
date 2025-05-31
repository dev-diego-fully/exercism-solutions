pub fn verse(n: u32) -> String {
    format!("{}\n{}", bottles_on_the_wall_line(n), action_line(n))
}

pub fn sing(start: u32, end: u32) -> String {
    bottles_count_evolution(start, end)
        .map(verse)
        .collect::<Vec<String>>()
        .join("\n\n")
}

fn bottles_count_evolution(start: u32, end: u32) -> impl Iterator<Item = u32> {
    (end..=start).rev()
}

fn bottles_on_the_wall_line(n: u32) -> String {
    match n {
        0 => String::from("No more bottles of beer on the wall, no more bottles of beer."),
        1 => String::from("1 bottle of beer on the wall, 1 bottle of beer."),
        _ => format!("{n} bottles of beer on the wall, {n} bottles of beer."),
    }
}

fn action_line(verse: u32) -> String {
    if verse == 0 {
        String::from(GO_AND_BUY)
    } else {
        take_one_down_line(verse - 1)
    }
}

fn take_one_down_line(remaining: u32) -> String {
    match remaining {
        0 => String::from("Take it down and pass it around, no more bottles of beer on the wall."),
        1 => String::from("Take one down and pass it around, 1 bottle of beer on the wall."),
        _ => format!("Take one down and pass it around, {remaining} bottles of beer on the wall."),
    }
}

const GO_AND_BUY: &str = "Go to the store and buy some more, 99 bottles of beer on the wall.";
