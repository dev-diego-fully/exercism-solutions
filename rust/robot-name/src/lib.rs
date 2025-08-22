//! This module defines the `Robot` struct and its related functionality.
//!
//! A `Robot` has a unique name that is generated and managed by a separate naming module.
mod namer;

/// A struct representing a robot with a unique name.
///
/// The name is a `String` and is assigned upon creation. It can be retrieved or
/// reset to a new unique value.
pub struct Robot {
    name: String
}

impl Robot {
    /// Creates a new `Robot` instance with a unique name.
    ///
    /// The name is generated using the `namer` module, which ensures it does not
    /// conflict with any previously assigned names.
    pub fn new() -> Self {
        Self {
            name: namer::get_new_name()
        }
    }

    /// Returns a string slice of the robot's name.
    pub fn name(&self) -> &str {
        &self.name
    }

    /// Resets the robot's name to a new, unique value.
    ///
    /// The old name is not reused, and a new unique name is generated.
    pub fn reset_name(&mut self) {
       self.name = namer::get_new_name()
    }
}