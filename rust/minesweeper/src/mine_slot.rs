/// Type represents a "square" on the minesweeper board. It can be an empty
/// space or contain a mine. Empty spaces have a count of how many
/// mines are near them.
#[derive(Clone, Copy)]
pub(crate) enum MineBoardSlot {
    FreeSpace(usize),
    Mine,
}

impl MineBoardSlot {
    /// Symbol representing a mine on the board (when in string form)
    pub(crate) const MINE_SYMBOL: char = '*';

    /// Creates a new empty space that has nearby mine count set to zero
    pub(crate) fn new_free() -> Self {
        Self::FreeSpace(0)
    }

    /// If it is an empty slot, returns a copy with the nearby mine
    /// count increased by 1.
    pub(crate) fn increment_near_mine_count(&self) -> Self {
        match self {
            Self::FreeSpace(v) => Self::FreeSpace(v + 1),
            Self::Mine => *self,
        }
    }

    ///Returns a suitable character to represent this square on the board.
    /// If it is a mine: '*';
    /// If it is a square with no nearby mines: ' ';
    /// Otherwise: it returns the number of nearby mines (1 to 8)
    pub(crate) fn to_char(self) -> char {
        match self {
            Self::Mine => Self::MINE_SYMBOL,
            Self::FreeSpace(0) => ' ',
            Self::FreeSpace(v) => (v as u8 + b'0') as char,
        }
    }
}
