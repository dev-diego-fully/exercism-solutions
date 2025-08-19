/// A struct representing a robot on a 2D plane.
///
/// The `Robot` has a position (`x`, `y`) and a direction. The movement and rotation methods
/// are implemented immutably, consuming the current instance and returning a new one with the
/// updated state. This approach prevents side effects and promotes a functional style of programming.
pub struct Robot {
    x: i32,
    y: i32,
    direction: Direction,
}

impl Robot {
    /// Creates a new `Robot` instance at the given position and with the specified direction.
    ///
    /// The new robot is initialized with the provided `x` and `y` coordinates and a starting `Direction`.
    pub fn new(x: i32, y: i32, d: Direction) -> Self {
        Self { x, y, direction: d }
    }

    /// Turns the robot 90 degrees to the right (clockwise).
    ///
    /// This method consumes the current `Robot` instance and returns a new one with the
    /// updated direction. The position remains unchanged.
    ///
    /// `#[must_use]` - This attribute indicates that the function's return value should not
    /// be ignored, as the original `Robot` instance is consumed and the new one contains the updated state.
    #[must_use]
    pub fn turn_right(self) -> Self {
        match self.direction {
            Direction::North => self.fork_with_direction(Direction::East),
            Direction::East => self.fork_with_direction(Direction::South),
            Direction::South => self.fork_with_direction(Direction::West),
            Direction::West => self.fork_with_direction(Direction::North),
        }
    }

    /// Turns the robot 90 degrees to the left (counter-clockwise).
    ///
    /// This method consumes the current `Robot` instance and returns a new one with the
    /// updated direction. The position remains unchanged.
    ///
    /// `#[must_use]` - The returned instance should not be ignored as it holds the updated state.
    #[must_use]
    pub fn turn_left(self) -> Self {
        match self.direction {
            Direction::North => self.fork_with_direction(Direction::West),
            Direction::East => self.fork_with_direction(Direction::North),
            Direction::South => self.fork_with_direction(Direction::East),
            Direction::West => self.fork_with_direction(Direction::South),
        }
    }

    /// Moves the robot one step forward in its current direction.
    ///
    /// This method consumes the current `Robot` instance and returns a new one with the
    /// updated position. The direction remains unchanged.
    ///
    /// `#[must_use]` - The returned instance should not be ignored as it holds the updated state.
    #[must_use]
    pub fn advance(self) -> Self {
        match self.direction {
            Direction::North => self.fork_with_y(self.y + 1),
            Direction::East => self.fork_with_x(self.x + 1),
            Direction::South => self.fork_with_y(self.y - 1),
            Direction::West => self.fork_with_x(self.x - 1),
        }
    }

    /// Executes a series of instructions from a string.
    ///
    /// This method processes a sequence of characters, where 'A' corresponds to `advance`,
    /// 'R' to `turn_right`, and 'L' to `turn_left`. It consumes the current `Robot` instance
    /// and returns a new one representing the final state after all instructions have been executed.
    ///
    /// `#[must_use]` - The returned instance should not be ignored as it holds the final state.
    pub fn instructions(self, instructions: &str) -> Self {
        instructions.chars().fold(self, Self::exec_instruction)
    }

    /// Returns the current position of the robot as a tuple of `(x, y)` coordinates.
    pub fn position(&self) -> (i32, i32) {
        (self.x, self.y)
    }

    /// Returns a reference to the robot's current direction.
    pub fn direction(&self) -> &Direction {
        &self.direction
    }
}

/// An enumeration representing the four cardinal directions.
#[derive(PartialEq, Eq, Debug, Clone, Copy)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

impl Robot {
    /// A private helper method to create a new `Robot` instance with a different direction.
    fn fork_with_direction(&self, direction: Direction) -> Self {
        Self::new(self.x, self.y, direction)
    }

    /// A private helper method to create a new `Robot` instance with a different x-coordinate.
    fn fork_with_x(&self, x: i32) -> Self {
        Self::new(x, self.y, self.direction)
    }

    /// A private helper method to create a new `Robot` instance with a different y-coordinate.
    fn fork_with_y(&self, y: i32) -> Self {
        Self::new(self.x, y, self.direction)
    }

    /// Executes a single instruction based on a character.
    ///
    /// This method is designed to be used with iterator-based operations like `fold`.
    fn exec_instruction(self, instruction: char) -> Self {
        match instruction {
            'A' => self.advance(),
            'R' => self.turn_right(),
            'L' => self.turn_left(),
            _ => self,
        }
    }
}