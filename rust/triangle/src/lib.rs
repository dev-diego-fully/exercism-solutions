use num_traits::Zero;

pub struct Triangle<T>(T, T, T);

impl<T> Triangle<T>
where
    T: Zero + PartialEq + PartialOrd + Copy,
{
    pub fn build(sides: [T; 3]) -> Option<Triangle<T>> {
        if !Triangle::all_positives(sides) || !Triangle::satisfies_inequalities(sides) {
            None
        } else {
            Some(Self(sides[0], sides[1], sides[2]))
        }
    }

    pub fn is_equilateral(&self) -> bool {
        self.0 == self.1 && self.1 == self.2
    }

    pub fn is_scalene(&self) -> bool {
        [self.0 != self.1, self.0 != self.2, self.1 != self.2]
            .into_iter()
            .all(|v| v)
    }

    pub fn is_isosceles(&self) -> bool {
        [self.0 == self.1, self.0 == self.2, self.1 == self.2]
            .into_iter()
            .any(|v| v)
    }

    fn satisfies_inequalities(sides: [T; 3]) -> bool {
        let [a, b, c] = sides;

        [a + b >= c, a + c >= b, b + c >= a].into_iter().all(|v| v)
    }

    fn all_positives(sides: [T; 3]) -> bool {
        sides.into_iter().any(|v| v > T::zero())
    }
}
