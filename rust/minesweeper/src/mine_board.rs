use crate::mine_slot::MineBoardSlot;
use std::cmp::min;

/// Type represents a minesweeper board. It has 0 or more MineBoardSlots,
/// distributed two-dimensionally. It uses a matrix internally.
pub(crate) struct MineBoard {
    elements: Vec<Vec<MineBoardSlot>>,
    width: usize,
    height: usize,
}

impl MineBoard {
    /// Creates a new board with the given width and height.
    /// All squares are initialized as empty space with no
    /// nearby mines [FreeSpace(0)]
    pub(crate) fn new(width: usize, height: usize) -> Self {
        Self {
            elements: vec![vec![MineBoardSlot::new_free(); width]; height],
            width,
            height,
        }
    }

    /// Create a new board from the "string board" format
    /// expected by the main "annotate" function
    pub(crate) fn from(board: &[&str]) -> Self {
        let (width, height) = board_dimensions(board);

        let mut this_board = Self::new(width, height);
        for_each_mine(board, |mine| {
            this_board.place_mine(mine)
        });

        this_board
    }

    /// Converts the board to the expected format as returned
    /// by the annotate(Vec<String>) function
    pub(crate) fn to_vec_string(&self) -> Vec<String> {
        self.elements
            .iter()
            .map(|v| Self::line_to_str(v))
            .collect()
    }

    /// Convert a board line (e[Mine Board Slot]) to a String
    fn line_to_str(line: &[MineBoardSlot]) -> String {
        line.iter()
            .map(|mbs: &MineBoardSlot| mbs.to_char())
            .collect()
    }

    /// Returns a vector containing the coordinates of all neighbors
    /// of the square with the given position, which are empty spaces.
    fn empty_neighbors(&self, (x, y): (usize, usize)) -> Vec<(usize, usize)> {
        let x_start = if x == 0 { 0 } else { x - 1 };
        let y_start = if y == 0 { 0 } else { y - 1 };
        let x_end = min(x + 2, self.width);
        let y_end = min(y + 2, self.height);

        (x_start..x_end)
            .flat_map(|x| (y_start..y_end).map(move |y| (x, y)))
            .filter(|coord: &(usize, usize)| self.is_free_space(*coord))
            .collect()
    }

    /// Returns whether or not the square at the given position is
    /// an empty (non-mine) space.
    fn is_free_space(&self, (x, y): (usize, usize)) -> bool {
        if self.width < x || self.height < y {
            return false;
        }
        matches!(
            self.elements[y][x],
            MineBoardSlot::FreeSpace(_)
        )
    }

    /// Places a new mine in the square at the given coordinate and
    /// updates the nearby mine count of all nearby empty squares.
    fn place_mine(&mut self, (x, y): (usize, usize)) {
        self.elements[y][x] = MineBoardSlot::Mine;
        let near_spaces = self.empty_neighbors((x, y));

        near_spaces
            .iter()
            .for_each(|&(x, y)| self.update_nearby_mine_count((x, y)));
    }

    /// Updates count of mines near the given coordinate square.
    fn update_nearby_mine_count(&mut self, (x, y): (usize, usize)) {
        self.elements[y][x] = self.elements[y][x].increment_near_mine_count()
    }
}

/// Executes the `operation` callback for all `minefield`
/// squares that have mines. The operation function only
/// receives the coordinate of each of these squares.
fn for_each_mine(
    minefield: &[&str],
    mut operation: impl FnMut((usize, usize)),
) {
    let (width, height) = board_dimensions(minefield);

    (0..width)
        .flat_map(|x| (0..height).map(move |y| (x, y)))
        .for_each(|(x, y)| {
            if minefield[y].as_bytes()[x] as char == MineBoardSlot::MINE_SYMBOL
            {
                operation((x, y))
            }
        });
}

/// Returns the dimensions of the given minefield.
/// Only works with rectangular minefields.
fn board_dimensions(minefield: &[&str]) -> (usize, usize) {
    let height = minefield.len();
    let width = if height > 0 { minefield[0].len() } else { 0 };
    (width, height)
}
