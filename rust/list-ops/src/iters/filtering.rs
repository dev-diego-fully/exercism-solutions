/// Filter Iterator. Iterates through all the elements of the original
/// iterator, but omits any that are not passed by the filter function.
pub(crate) struct Filtered<I, F>
where
    I: Iterator,
    F: Fn(&I::Item) -> bool,
{
    original: I,
    predicate: F,
}

impl<I, F> Filtered<I, F>
where
    I: Iterator,
    F: Fn(&I::Item) -> bool,
{
    /// Returns an iterator that traverses all elements of the given original
    /// iterator. However, it omits all those elements that are not passed by
    /// the filter function (predicate).
    pub(crate) fn from(iter: I, predicate: F) -> Self {
        Self {
            original: iter,
            predicate,
        }
    }
}

impl<I, F> Iterator for Filtered<I, F>
where
    I: Iterator,
    F: Fn(&I::Item) -> bool,
{
    type Item = I::Item;

    fn next(&mut self) -> Option<Self::Item> {
        loop {
            match self.original.next() {
                None => return None,
                Some(v) => {
                    if (self.predicate)(&v) {
                        return Some(v);
                    }
                }
            }
        }
    }
}
