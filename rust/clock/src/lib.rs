use std::fmt::Display;

#[derive(PartialEq, Eq, Debug)]
pub struct Clock {
    total_minutes: u16,
}

impl Clock {
    const MINUTES_IN_HOURS: u8 = 60;
    const MAX_MINUTES: u16 = 24 * 60;

    pub fn new(hours: i32, minutes: i32) -> Self {
        let time = hours as i64 * Self::MINUTES_IN_HOURS as i64 + minutes as i64;
        Self::from_time(time)
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        let new_time = minutes as i64 + self.total_minutes as i64;
        Self::from_time(new_time)
    }

    fn from_time(time: i64) -> Self {
        let real_time = (time % Self::MAX_MINUTES as i64) as i16;
        let base_time = if time >= 0 {
            0
        } else {
            Self::MAX_MINUTES as i16
        };
        Self {
            total_minutes: (base_time + real_time) as u16,
        }
    }

    fn hours(&self) -> u8 {
        (self.total_minutes / Self::MINUTES_IN_HOURS as u16) as u8
    }

    fn minutes(&self) -> u8 {
        (self.total_minutes % Self::MINUTES_IN_HOURS as u16) as u8
    }
}

impl Display for Clock {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{:02}:{:02}", self.hours(), self.minutes())
    }
}
