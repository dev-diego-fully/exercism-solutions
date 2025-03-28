mod mine_board;
mod mine_slot;

/// Adds the count of nearby mines to the empty spaces on the given board.
pub fn annotate(minefield: &[&str]) -> Vec<String> {
    mine_board::MineBoard::from(minefield).to_vec_string()
}
