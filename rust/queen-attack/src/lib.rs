//! This module defines data structures and logic for representing chess positions and queens,
//! including the ability to determine if two queens can attack each other.

/// Represents a position on a standard 8x8 chessboard.
///
/// A position is defined by its `rank` (row) and `file` (column).
#[derive(Debug)]
pub struct ChessPosition {
    rank: i32,
    file: i32,
}

/// Represents a Queen piece on a chessboard.
///
/// Each queen has a specific `ChessPosition`.
#[derive(Debug)]
pub struct Queen {
    position: ChessPosition,
}

impl ChessPosition {
    /// Creates a new `ChessPosition`.
    ///
    /// Returns `Some(ChessPosition)` if the given rank and file are within the valid board range (0-7),
    /// otherwise returns `None`.
    ///
    /// # Arguments
    ///
    /// * `rank` - The rank (row) of the position.
    /// * `file` - The file (column) of the position.
    pub fn new(rank: i32, file: i32) -> Option<Self> {
        match (rank, file) {
            (0..8, 0..8) => Some(Self { rank, file }),
            _ => None,
        }
    }

    /// Checks if this position is on the same rank as another position.
    ///
    /// # Arguments
    ///
    /// * `other` - A reference to the other `ChessPosition`.
    ///
    /// # Returns
    ///
    /// `true` if both positions share the same rank, `false` otherwise.
    fn same_rank(&self, other: &Self) -> bool {
        self.rank == other.rank
    }

    /// Checks if this position is on the same file as another position.
    ///
    /// # Arguments
    ///
    /// * `other` - A reference to the other `ChessPosition`.
    ///
    /// # Returns
    ///
    /// `true` if both positions share the same file, `false` otherwise.
    fn same_file(&self, other: &Self) -> bool {
        self.file == other.file
    }

    /// Checks if this position is on the same diagonal as another position.
    ///
    /// Two positions are on the same diagonal if the absolute difference of their ranks
    /// is equal to the absolute difference of their files.
    ///
    /// # Arguments
    ///
    /// * `other` - A reference to the other `ChessPosition`.
    ///
    /// # Returns
    ///
    /// `true` if both positions are on the same diagonal, `false` otherwise.
    fn same_diagonal(&self, other: &Self) -> bool {
        let delta_file = self.file - other.file;
        let delta_rank = self.rank - other.rank;

        delta_file.abs() == delta_rank.abs()
    }
}

impl Queen {
    /// Creates a new `Queen` at the specified `ChessPosition`.
    ///
    /// # Arguments
    ///
    /// * `position` - The `ChessPosition` where the queen is located.
    pub fn new(position: ChessPosition) -> Self {
        Self { position }
    }

    /// Determines if this queen can attack another queen.
    ///
    /// A queen can attack another queen if they are on the same rank, file, or diagonal.
    ///
    /// # Arguments
    ///
    /// * `other` - A reference to the other `Queen`.
    ///
    /// # Returns
    ///
    /// `true` if this queen can attack the `other` queen, `false` otherwise.
    pub fn can_attack(&self, other: &Queen) -> bool {
        let pos_a = &self.position;
        let pos_b = &other.position;

        [
            ChessPosition::same_rank,
            ChessPosition::same_file,
            ChessPosition::same_diagonal,
        ]
        .iter()
        .any(|checker| checker(pos_a, pos_b))
    }
}
