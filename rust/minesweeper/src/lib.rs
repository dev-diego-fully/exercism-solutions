use std::cmp::min;

pub fn annotate(minefield: &[&str]) -> Vec<String> {
    MineBoard::from(minefield).to_vec_string()
}

fn for_mine(minefield: &[&str], mut operation: impl FnMut((usize, usize))) {
    let (width, height) = board_dimensions(minefield);

    (0..width)
        .flat_map(|x| (0..height).map(move |y| (x, y)))
        .for_each(|(x, y)| {
            if minefield[y].as_bytes()[x] as char == MineBoardSlot::MINE_SYMBOL {
                operation((x, y))
            }
        });
}

fn board_dimensions(minefield: &[&str]) -> (usize, usize) {
    let height = minefield.len();
    let width = if height > 0 { minefield[0].len() } else { 0 };
    (width, height)
}

#[derive(Clone, Copy)]
enum MineBoardSlot {
    FreeSpace(usize),
    Mine,
}

impl MineBoardSlot {
    const MINE_SYMBOL: char = '*';

    fn free() -> Self {
        Self::FreeSpace(0)
    }

    fn new_nearby(&self) -> Self {
        match self {
            Self::FreeSpace(v) => Self::FreeSpace(v + 1),
            Self::Mine => Self::Mine,
        }
    }

    fn to_char(self) -> char {
        match self {
            Self::Mine => Self::MINE_SYMBOL,
            Self::FreeSpace(0) => ' ',
            Self::FreeSpace(v) => (v as u8 + b'0') as char,
        }
    }
}

struct MineBoard {
    elements: Vec<Vec<MineBoardSlot>>,
    width: usize,
    height: usize,
}

impl MineBoard {
    fn new(width: usize, height: usize) -> Self {
        Self {
            elements: vec![vec![MineBoardSlot::free(); width]; height],
            width,
            height,
        }
    }

    fn from(board: &[&str]) -> Self {
        let (width, height) = board_dimensions(board);

        let mut this_board = Self::new(width, height);
        let place_mine = |mine| this_board.place_mine(mine);
        for_mine(board, place_mine);
        this_board
    }

    fn line_to_str(line: &Vec<MineBoardSlot>) -> String {
        line.iter().map(|mbs| mbs.to_char()).collect()
    }

    fn empty_neighbors(&self, (x, y): (usize, usize)) -> Vec<(usize, usize)> {
        let x_start = if x == 0 { 0 } else { x - 1 };
        let y_start = if y == 0 { 0 } else { y - 1 };
        let x_end = min(x + 2, self.width);
        let y_end = min(y + 2, self.height);

        let pair_with_y = move |x| (y_start..y_end).map(move |y| (x, y));
        let only_free_space = |coord: &(usize, usize)| self.is_free_space(*coord);

        (x_start..x_end)
            .flat_map(pair_with_y)
            .filter(only_free_space)
            .collect()
    }

    fn is_free_space(&self, (x, y): (usize, usize)) -> bool {
        if self.width < x || self.height < y {
            return false;
        }
        matches!(self.elements[y][x], MineBoardSlot::FreeSpace(_))
    }

    fn place_mine(&mut self, (x, y): (usize, usize)) {
        self.elements[y][x] = MineBoardSlot::Mine;
        let near_spaces = self.empty_neighbors((x, y));
        let update_near_mine_count = |&(x, y)| self.register_nearby_bomb((x, y));

        near_spaces.iter().for_each(update_near_mine_count);
    }

    fn register_nearby_bomb(&mut self, (x, y): (usize, usize)) {
        self.elements[y][x] = self.elements[y][x].new_nearby()
    }

    fn to_vec_string(&self) -> Vec<String> {
        self.elements.iter().map(Self::line_to_str).collect()
    }
}
