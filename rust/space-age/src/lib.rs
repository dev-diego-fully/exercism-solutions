/// Custom type to represent time durations.
#[derive(Debug)]
pub struct Duration {
    seconds: u64,
}

impl From<u64> for Duration {
    /// Creates a new instance from the given number of seconds.
    fn from(s: u64) -> Self {
        Self { seconds: s }
    }
}

/// Returns the number of years that the number of seconds represents on the planet.
pub trait Planet {
    const YEAR_DURATION_SECONDS: f64;

    fn years_during(d: &Duration) -> f64 {
        (d.seconds as f64) / (Self::YEAR_DURATION_SECONDS)
    }
}

/// Macro for implementing a new struct that implements the Planet trait.
macro_rules! define_planet {
    ($name: ident, $period:expr) => {
        pub struct $name;

        impl Planet for $name {
            const YEAR_DURATION_SECONDS: f64 = EARTH_YEAR_DURATION_IN_SECONDS * $period;
        }
    };
}

define_planet!(Mercury, 0.2408467);
define_planet!(Venus, 0.61519726);
define_planet!(Earth, 1.0);
define_planet!(Mars, 1.8808158);
define_planet!(Jupiter, 11.862615);
define_planet!(Saturn, 29.447498);
define_planet!(Uranus, 84.016846);
define_planet!(Neptune, 164.79132);

/// Duration in seconds of a year on planet Earth. Calculated as:
/// days in a year * hours in a day * minutes in an hour * seconds in a minute.
const EARTH_YEAR_DURATION_IN_SECONDS: f64 = 365.25 * 24.0 * 60.0 * 60.0;
