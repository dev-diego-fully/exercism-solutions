#[derive(Clone, Copy)]
pub(crate) enum MineBoardSlot {
    FreeSpace(usize),
    Mine,
}

impl MineBoardSlot {
    pub(crate) const MINE_SYMBOL: char = '*';

    pub(crate) fn new_free() -> Self {
        Self::FreeSpace(0)
    }

    pub(crate) fn new_nearby(&self) -> Self {
        match self {
            Self::FreeSpace(v) => Self::FreeSpace(v + 1),
            Self::Mine => Self::Mine,
        }
    }

    pub(crate) fn to_char(self) -> char {
        match self {
            Self::Mine => Self::MINE_SYMBOL,
            Self::FreeSpace(0) => ' ',
            Self::FreeSpace(v) => (v as u8 + b'0') as char,
        }
    }
}
