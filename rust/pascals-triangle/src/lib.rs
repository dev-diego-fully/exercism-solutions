/// A struct representing a Pascal's Triangle.
///
/// It holds the number of rows to be generated. The triangle's rows and elements are calculated lazily
/// when requested by the `rows` method.
pub struct PascalsTriangle {
    rows_count: u32,
}

impl PascalsTriangle {
    /// Creates a new `PascalsTriangle` instance.
    ///
    /// # Arguments
    ///
    /// * `row_count` - The number of rows to generate in the triangle.
    pub fn new(row_count: u32) -> Self {
        Self {
            rows_count: row_count,
        }
    }

    /// Generates and returns all rows of the Pascal's Triangle.
    ///
    /// The method iterates from row 0 to the specified `rows_count`,
    /// calling the `row` helper function for each one.
    ///
    /// # Returns
    ///
    /// A vector of vectors, where each inner vector represents a row of the triangle.
    pub fn rows(&self) -> Vec<Vec<u32>> {
        (0..self.rows_count).map(|row| self.row(row)).collect()
    }

    /// Generates a single row of the Pascal's Triangle at a given index.
    ///
    /// It iterates from position 0 up to the row index, calculating the value of each element.
    ///
    /// # Arguments
    ///
    /// * `index` - The 0-based index of the row to generate.
    ///
    /// # Returns
    ///
    /// A vector of `u32` representing the elements of the specified row.
    fn row(&self, index: u32) -> Vec<u32> {
        (0..=index).map(|pos| self.element(index, pos)).collect()
    }

    /// Calculates the value of a single element in the triangle using the combinatorial formula.
    ///
    /// The formula used is C(n, k) = n! / (k! * (n-k)!), where `n` is the row number and `k`
    /// is the column.
    ///
    /// # Arguments
    ///
    /// * `row` - The row index of the element.
    /// * `col` - The column index of the element.
    ///
    /// # Returns
    ///
    /// The `u32` value of the element at the specified position.
    fn element(&self, row: u32, col: u32) -> u32 {
        let fat_row = factorial(row);
        let fat_col = factorial(col);
        let fat_diff = factorial(row - col);
        fat_row / (fat_col * fat_diff)
    }
}

/// Calculates the factorial of a given number.
///
/// It uses an iterator and a `reduce` operation to compute the factorial. The factorial of 0 is 1.
///
/// # Arguments
///
/// * `n` - The number for which to calculate the factorial.
///
/// # Returns
///
/// The factorial of `n` as a `u32` unsigned integer.
fn factorial(n: u32) -> u32 {
    (1..=n).reduce(|acc, v| acc * v).unwrap_or(1)
}