/// A struct that represents a person's allergies using a numerical score (bitmask).
/// Each allergen corresponds to a unique power of 2, allowing for efficient storage and checking.
pub struct Allergies {
    score: u32,
}

impl Allergies {
    /// Creates a new `Allergies` instance from a given score.
    ///
    /// The score is a bitmask where each set bit indicates an allergy.
    ///
    /// # Arguments
    ///
    /// * `score` - The numerical bitmask representing the user's allergies.
    pub fn new(score: u32) -> Self {
        Self { score }
    }

    /// Checks if a person is allergic to a specific allergen.
    ///
    /// This method performs a bitwise AND operation between the stored `score` and the allergen's
    /// unique score. A non-zero result indicates the allergy is present.
    ///
    /// # Arguments
    ///
    /// * `allergen` - A reference to the `Allergen` to check for.
    ///
    /// # Returns
    ///
    /// `true` if the person is allergic to the allergen, `false` otherwise.
    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        self.score & allergen.score() as u32 != 0
    }

    /// Returns a vector of all allergens a person is allergic to.
    ///
    /// The method iterates through the predefined list of all allergens,
    /// filtering for those that are present in the instance's score.
    ///
    /// # Returns
    ///
    /// A `Vec<Allergen>` containing the list of a person's allergies.
    pub fn allergies(&self) -> Vec<Allergen> {
        Allergen::list()
            .iter()
            .filter(|&al| self.is_allergic_to(al))
            .copied()
            .collect()
    }
}

/// An enumeration representing the possible allergens.
///
/// Each variant is annotated with a unique power-of-2 value, which serves as its bitmask value.
#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

impl Allergen {
    /// Returns a vector containing all possible `Allergen` variants in a defined order.
    ///
    /// # Returns
    ///
    /// A `Vec<Self>` containing all allergens.
    fn list() -> Vec<Self> {
        vec![
            Self::Eggs,
            Self::Peanuts,
            Self::Shellfish,
            Self::Strawberries,
            Self::Tomatoes,
            Self::Chocolate,
            Self::Pollen,
            Self::Cats,
        ]
    }

    /// Returns the unique bitmask value for a specific allergen.
    ///
    /// # Returns
    ///
    /// The `u8` score associated with the allergen.
    fn score(&self) -> u8 {
        match self {
            Allergen::Eggs => 1,
            Allergen::Peanuts => 2,
            Allergen::Shellfish => 4,
            Allergen::Strawberries => 8,
            Allergen::Tomatoes => 16,
            Allergen::Chocolate => 32,
            Allergen::Pollen => 64,
            Allergen::Cats => 128,
        }
    }
}
