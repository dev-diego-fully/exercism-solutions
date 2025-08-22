//! This module is responsible for generating unique and thread-safe robot names.
//!
//! It uses a global, lazily-initialized `HashSet` to store all generated names,
//! ensuring no duplicates are produced. The set is protected by a `Mutex` to
//! guarantee thread-safe access.
use std::{
    collections::HashSet,
    ops::RangeInclusive,
    sync::{Mutex, MutexGuard, OnceLock},
};

use rand::Rng;

/// Generates a new, unique name for a robot.
///
/// The function repeatedly generates random names until it finds one that is not
/// already in the `RESERVED_NAMES` set. The newly generated name is then
/// inserted into the set before being returned.
pub(crate) fn get_new_name() -> String {
    let mut name_set = name_set();
    let mut name = random_name();

    while !name_set.insert(name.clone()) {
        name = random_name();
    }

    name
}

/// The number of letters in the English alphabet.
const ALPHABET_SIZE: u32 = 26;
/// The ASCII value of the starting character for uppercase letters ('A').
const UPPER_CASE_START: u32 = 'A' as u32;
/// The range of numbers to be used in the robot's name.
const ROBOT_NUMBER_RANGE: RangeInclusive<u32> = 1..=999;

/// A global, lazily-initialized set of all generated robot names.
///
/// The `OnceLock` ensures the `Mutex` and the `HashSet` are initialized only once,
/// and the `Mutex` guarantees thread-safe access to the name set.
static RESERVED_NAMES: OnceLock<Mutex<HashSet<String>>> = OnceLock::new();

/// Acquires a lock on the global name set.
///
/// This helper function simplifies accessing the `RESERVED_NAMES` by handling
/// the `get_or_init` and `lock` calls.
fn name_set() -> MutexGuard<'static, HashSet<String>> {
    RESERVED_NAMES
        .get_or_init(|| Mutex::new(HashSet::new()))
        .lock()
        .unwrap()
}

/// Generates a random name in the format "LLDDD", where 'L' is an uppercase
/// letter and 'D' is a digit.
fn random_name() -> String {
    format!(
        "{}{}{:03}",
        random_letter(),
        random_letter(),
        random_number()
    )
}

/// Generates a random uppercase letter.
fn random_letter() -> char {
    let letter_index: u32 = rand::rng().random_range(0..ALPHABET_SIZE);

    char::from_u32(UPPER_CASE_START + letter_index).unwrap()
}

/// Generates a random number within the predefined `ROBOT_NUMBER_RANGE`.
fn random_number() -> u32 {
    rand::rng().random_range(ROBOT_NUMBER_RANGE)
}