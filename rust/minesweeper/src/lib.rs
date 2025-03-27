mod mine_board;
mod mine_slot;

pub fn annotate(minefield: &[&str]) -> Vec<String> {
    mine_board::MineBoard::from(minefield).to_vec_string()
}
