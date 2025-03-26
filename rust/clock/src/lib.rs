use std::fmt::Display;

/// Type represents a clock with values ​​between 00:00 and 23:59
#[derive(PartialEq, Eq, Debug)]
pub struct Clock {
    total_minutes: u16,
}

impl Clock {
    const MINUTES_IN_HOURS: u8 = 60;
    const MAX_MINUTES: u16 = 24 * 60;

    /// Constructs a new Clock from the given amount of hours and minutes.
    pub fn new(hours: i32, minutes: i32) -> Self {
        let total_minutes = hours as i64 * Self::MINUTES_IN_HOURS as i64 + minutes as i64;
        Self::from(total_minutes)
    }

    /// Adds a new amount of minutes to the clock.
    pub fn add_minutes(&self, minutes: i32) -> Self {
        let new_total = minutes as i64 + self.total_minutes as i64;
        Self::from(new_total)
    }

    /// Creates a new Clock from the total minutes passed.
    fn from(minutes: i64) -> Self {
        let max_minutes = Self::MAX_MINUTES as i64;
        let adjusted = ((minutes % max_minutes) + max_minutes) % max_minutes;
        Self {
            total_minutes: adjusted as u16,
        }
    }

    /// Gets the number of hours displayed on the clock.
    fn hours(&self) -> u8 {
        (self.total_minutes / Self::MINUTES_IN_HOURS as u16) as u8
    }

    /// Gets the amount of minutes displayed on the clock.
    fn minutes(&self) -> u8 {
        (self.total_minutes % Self::MINUTES_IN_HOURS as u16) as u8
    }
}

impl Display for Clock {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{:02}:{:02}", self.hours(), self.minutes())
    }
}
