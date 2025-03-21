/// Base of geometric progression given square by square.
const SQUARE_PROGRESSION: u64 = 2;
/// Index (1-based) to the last square of the board.
const LAST_SQUARE: u32 = 64;

/// Returns the amount of grains corresponding to the square s.
pub fn square(s: u32) -> u64 {
    SQUARE_PROGRESSION.pow(s - 1)
}

/// Calculates and returns the total amount of grains across the board.
pub fn total() -> u64 {
    (1..LAST_SQUARE + 1).map(square).sum()
}
