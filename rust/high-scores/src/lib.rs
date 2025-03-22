/// Scoreboard structure to store scores of games already played.
#[derive(Debug)]
pub struct HighScores {
    history: Vec<u32>,
    highers: Vec<u32>,
}

impl HighScores {
    /// Creates a new scoreboard.
    pub fn new(scores: &[u32]) -> Self {
        Self {
            history: Vec::from(scores),
            highers: top_three(scores),
        }
    }

    /// Creates a new scoreboard from past scores.
    pub fn scores(&self) -> &[u32] {
        &self.history
    }

    /// Get the last recorded score.
    pub fn latest(&self) -> Option<u32> {
        self.history.last().map(u32::to_owned)
    }

    /// Gets the best score ever recorded.
    pub fn personal_best(&self) -> Option<u32> {
        self.highers.first().map(u32::to_owned)
    }

    /// Get the 3 best scores ever recorded.
    pub fn personal_top_three(&self) -> Vec<u32> {
        self.highers.clone()
    }
}

/// Returns a Vec containing the three highest scores found in the given vector.
fn top_three(vector: &[u32]) -> Vec<u32> {
    sorted(vector)
        .iter()
        .rev()
        .take(3)
        .map(&u32::to_owned)
        .collect()
}

/// Returns a sorted copy of the passed vector.
/// Converts the type of &[u32] to Vec<u32>.
fn sorted(vector: &[u32]) -> Vec<u32> {
    let mut copy = Vec::from(vector);
    copy.sort();
    copy
}
