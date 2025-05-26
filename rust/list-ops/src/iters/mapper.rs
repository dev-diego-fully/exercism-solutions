/// Mapping iterator. Iterates through each element of the original iterator,
/// but returns the result of that element when passed through the mapping
/// function, rather than returning the original element.
pub(crate) struct Mapper<I, F, U>
where
    I: Iterator,
    F: Fn(I::Item) -> U,
{
    original: I,
    mapper: F,
}

impl<I, F, U> Mapper<I, F, U>
where
    I: Iterator,
    F: Fn(I::Item) -> U,
{
    /// Returns an iterator that traverses each element of the original
    /// iterator, but returns the result of that element when passed
    /// through the mapping function, rather than returning the original
    /// element itself.
    pub(crate) fn from(iter: I, mapper: F) -> Self {
        Self {
            original: iter,
            mapper,
        }
    }
}

impl<I, F, U> Iterator for Mapper<I, F, U>
where
    I: Iterator,
    F: Fn(I::Item) -> U,
{
    type Item = U;

    fn next(&mut self) -> Option<Self::Item> {
        self.original.next().map(|value| (self.mapper)(value))
    }
}
