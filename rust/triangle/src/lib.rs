use num_traits::Zero;

/// Represents a triangle with three sides of a generic numeric type.
///
/// This struct is designed to validate if given side lengths form a valid triangle
/// and to classify the triangle by its side lengths. It is ideally suited for
/// integer, unsigned integer, or floating-point types.
/// Triangles with any negative side or that do not satisfy the triangle inequalities are considered invalid.
pub struct Triangle<T>(T, T, T);

impl<T> Triangle<T>
where
    T: Zero + PartialEq + PartialOrd + Copy,
{
    /// Attempts to construct a `Triangle` from an array of three side lengths.
    ///
    /// Returns `Some(Triangle)` if the sides form a valid triangle (i.e., all sides are positive
    /// and satisfy the triangle inequalities). Otherwise, returns `None`.
    pub fn build(sides: [T; 3]) -> Option<Triangle<T>> {
        if !Triangle::all_positives(sides) || !Triangle::satisfies_inequalities(sides) {
            None
        } else {
            Some(Self(sides[0], sides[1], sides[2]))
        }
    }

    /// Checks if the triangle is equilateral.
    ///
    /// An equilateral triangle has all three sides equal.
    pub fn is_equilateral(&self) -> bool {
        self.0 == self.1 && self.1 == self.2
    }

    /// Checks if the triangle is scalene.
    ///
    /// A scalene triangle has all three sides of different lengths.
    pub fn is_scalene(&self) -> bool {
        [self.0 != self.1, self.0 != self.2, self.1 != self.2]
            .into_iter()
            .all(|v| v)
    }

    /// Checks if the triangle is isosceles.
    ///
    /// An isosceles triangle has at least two sides of equal length.
    pub fn is_isosceles(&self) -> bool {
        [self.0 == self.1, self.0 == self.2, self.1 == self.2]
            .into_iter()
            .any(|v| v)
    }

    /// Checks if the given side lengths satisfy the triangle inequalities.
    ///
    /// The sum of the lengths of any two sides of a triangle must be greater than or equal to the length of the third side.
    fn satisfies_inequalities(sides: [T; 3]) -> bool {
        let [a, b, c] = sides;

        [a + b >= c, a + c >= b, b + c >= a].into_iter().all(|v| v)
    }

    /// Checks if all given side lengths are positive.
    ///
    /// Side lengths must be positive to be geometrically valid.
    fn all_positives(sides: [T; 3]) -> bool {
        sides.into_iter().any(|v| v > T::zero())
    }
}
