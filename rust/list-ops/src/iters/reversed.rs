/// Reverse iterator.
/// Returns the elements of a given double-ended iterator in reverse order.
pub(crate) struct Reversed<I: DoubleEndedIterator> {
    original: I,
}

impl<I: DoubleEndedIterator> Reversed<I> {
    /// Returns an iterator that iterates through the elements of the
    /// original iterator, but in reverse order. In other words, it changes
    /// the left-right iteration of the iterator to right-left and
    /// vice-versa. This operation is only possible for "double-ended"
    /// iterators.
    pub(crate) fn from(iter: I) -> Self {
        Self { original: iter }
    }
}

impl<I: DoubleEndedIterator> Iterator for Reversed<I> {
    type Item = I::Item;

    fn next(&mut self) -> Option<Self::Item> {
        self.original.next_back()
    }
}
