/// Creates a raindrop sound from the given number. If the number
/// is not divisible by 3, 5, or 7, returns the number as a string.
pub fn raindrops(n: u32) -> String {
    let drop_sound = SOUNDS
        .iter()
        .filter_map(|sound| parse_sound(n, sound))
        .collect::<String>();

    if drop_sound.is_empty() {
        n.to_string()
    } else {
        drop_sound
    }
}

/// Returns the sound of the given raindrop, if the given number is
/// divisible by the drop check number.
fn parse_sound<'a>(n: u32, raindrop: &'a RaindropSound<'a>) -> Option<&'a str> {
    if n % raindrop.1 == 0 {
        Some(raindrop.0)
    } else {
        None
    }
}

/// The type of a raindrop. It has its sound and its check divider.
type RaindropSound<'a> = (&'a str, u32);

/// List of recorded raindrop sounds, paired with their respective check divisor.
const SOUNDS: [RaindropSound; 3] = [("Pling", 3), ("Plang", 5), ("Plong", 7)];
