/// A concatenation iterator. It is similar to append, but for multiple
/// iterators. It will iterate through each iterator in the iterator
/// "list", advancing to the next one each time it exhausts the current
/// iterator. When the iterator "list" is exhausted, the iterator is
/// considered exhausted.
pub(crate) struct Concated<I>
where
    I: Iterator,
    I::Item: Iterator,
{
    sources: I,
    current: Option<I::Item>,
}

impl<I> Concated<I>
where
    I: Iterator,
    I::Item: Iterator,
{
    /// Create a new emperor that will iterate through each element of each
    /// iterator within the given nested iterator.
    /// Advance to the next iterator in the "list" each time the current
    /// iterator is exhausted.
    ///
    /// Hide each iterator exhaustion, generating
    /// an iteration without "holes".
    pub(crate) fn from(nested: I) -> Self {
        let mut copy = nested;
        Self {
            current: copy.next(),
            sources: copy,
        }
    }

    /// Returns whether or not this iterator has been exhausted.
    fn has_ended(&self) -> bool {
        self.current.is_none()
    }

    /// Returns the next element of the current iterator. Will return None
    /// if the current iterator (NOT THIS ONE) has been exhausted.
    fn next_element(&mut self) -> Option<<<I as Iterator>::Item as Iterator>::Item> {
        match &mut self.current {
            None => None,
            Some(iter) => iter.next(),
        }
    }
    
    /// Returns the next iterator in the "list" of iterators (passed during
    /// construction). It will return None if there are no more iterators,
    /// which also means that this iterator has been exhausted.
    fn next_iter(&mut self) -> Option<I::Item> {
        self.sources.next()
    }
}

impl<I> Iterator for Concated<I>
where
    I: Iterator,
    I::Item: Iterator,
{
    type Item = <<I as Iterator>::Item as Iterator>::Item;

    fn next(&mut self) -> Option<Self::Item> {
        while !self.has_ended() {
            match self.next_element() {
                None => self.current = self.next_iter(),
                value => return value,
            }
        }
        None
    }
}
