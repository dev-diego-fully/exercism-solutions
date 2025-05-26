/// An append iterator. Iterates over all the elements of the left iterator
/// and when those are gone, it iterates over the ones on the right.
pub(crate) struct Appended<I, J>
where
    I: Iterator,
    J: Iterator<Item = I::Item>,
{
    left: I,
    right: J,
}

impl<I, J> Appended<I, J>
where
    I: Iterator,
    J: Iterator<Item = I::Item>,
{
    /// Create an iterator that traverses the elements of the left iterator
    /// until it is exhausted and then traverses the elements on the right
    /// until it is exhausted as well.
    pub(crate) fn from(left: I, right: J) -> Self {
        Self { left, right }
    }
}

impl<I, J> Iterator for Appended<I, J>
where
    I: Iterator,
    J: Iterator<Item = I::Item>,
{
    type Item = I::Item;

    fn next(&mut self) -> Option<Self::Item> {
        self.left.next().or_else(|| self.right.next())
    }
}
