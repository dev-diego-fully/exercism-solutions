use std::fmt::{Display, Formatter, Result};

/// A struct that represents a number in Roman numerals.
///
/// This struct holds the string representation of a Roman number. Its primary purpose
/// is to facilitate the conversion from an unsigned integer (`u32`) and to allow for
/// easy display as a string.
pub struct Roman {
    representation: String,
}

impl Display for Roman {
    /// Implements the `Display` trait to allow the `Roman` struct to be formatted as a string.
    ///
    /// This implementation simply writes the internal `representation` string to the formatter.
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        write!(f, "{}", self.representation)
    }
}

impl From<u32> for Roman {
    /// Implements the `From` trait to convert a `u32` integer into a `Roman` struct.
    ///
    /// The conversion is performed greedily by iterating through the `RomanicAtom` values
    /// from largest to smallest. For each atom, it subtracts its value from the number as
    /// many times as possible, appending the corresponding Roman representation to the result.
    fn from(num: u32) -> Self {
        let mut current = num;
        let mut representation = String::new();

        for atom in RomanicAtom::list().iter().rev() {
            while current >= atom.value() {
                current -= atom.value();
                representation.push_str(atom.representation());
            }
        }

        Self { representation }
    }
}

/// An enumeration representing the fundamental Roman numeral "atoms" or building blocks.
///
/// This enum includes not only the standard single-character symbols (e.g., `One`, `Ten`)
/// but also the subtractive forms (e.g., `Four`, `Nine`) to ensure the most efficient
/// conversion algorithm, which relies on a greedy approach.
enum RomanicAtom {
    One,
    Four,
    Five,
    Nine,
    Ten,
    Forty,
    Fifty,
    Ninety,
    Hundred,
    FourHundred,
    FiveHundred,
    NineHundred,
    Thousand,
}

impl RomanicAtom {
    /// Returns the decimal value of the Romanic atom.
    ///
    /// For example, calling `.value()` on `RomanicAtom::Four` returns `4`.
    fn value(&self) -> u32 {
        match self {
            RomanicAtom::One => 1,
            RomanicAtom::Four => 4,
            RomanicAtom::Five => 5,
            RomanicAtom::Nine => 9,
            RomanicAtom::Ten => 10,
            RomanicAtom::Forty => 40,
            RomanicAtom::Fifty => 50,
            RomanicAtom::Ninety => 90,
            RomanicAtom::Hundred => 100,
            RomanicAtom::FourHundred => 400,
            RomanicAtom::FiveHundred => 500,
            RomanicAtom::NineHundred => 900,
            RomanicAtom::Thousand => 1000,
        }
    }

    /// Returns the string representation of the Romanic atom.
    ///
    /// For example, calling `.representation()` on `RomanicAtom::Four` returns `"IV"`.
    fn representation(&self) -> &str {
        match self {
            RomanicAtom::One => "I",
            RomanicAtom::Four => "IV",
            RomanicAtom::Five => "V",
            RomanicAtom::Nine => "IX",
            RomanicAtom::Ten => "X",
            RomanicAtom::Forty => "XL",
            RomanicAtom::Fifty => "L",
            RomanicAtom::Ninety => "XC",
            RomanicAtom::Hundred => "C",
            RomanicAtom::FourHundred => "CD",
            RomanicAtom::FiveHundred => "D",
            RomanicAtom::NineHundred => "CM",
            RomanicAtom::Thousand => "M",
        }
    }

    /// Returns a vector of all `RomanicAtom` variants, ordered from smallest to largest value.
    ///
    /// This list is crucial for the conversion algorithm, as it allows for an ordered,
    /// greedy iteration.
    fn list() -> Vec<Self> {
        vec![
            RomanicAtom::One,
            RomanicAtom::Four,
            RomanicAtom::Five,
            RomanicAtom::Nine,
            RomanicAtom::Ten,
            RomanicAtom::Forty,
            RomanicAtom::Fifty,
            RomanicAtom::Ninety,
            RomanicAtom::Hundred,
            RomanicAtom::FourHundred,
            RomanicAtom::FiveHundred,
            RomanicAtom::NineHundred,
            RomanicAtom::Thousand,
        ]
    }
}