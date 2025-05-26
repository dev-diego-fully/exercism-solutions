mod iters;

/// Yields each item of a and then each item of b.
pub fn append<I, J>(a: I, b: J) -> impl Iterator<Item = I::Item>
where
    I: Iterator,
    J: Iterator<Item = I::Item>,
{
    iters::Appended::from(a, b)
}

/// Combines all items in all nested iterators inside into one flattened
/// iterator.
pub fn concat<I>(nested_iter: I) -> impl Iterator<Item = <I::Item as Iterator>::Item>
where
    I: Iterator,
    I::Item: Iterator,
{
    iters::Concated::from(nested_iter)
}

/// Returns an iterator of all items in iter for which `predicate(item)`
/// is true.
pub fn filter<I, F>(iter: I, predicate: F) -> impl Iterator<Item = I::Item>
where
    I: Iterator,
    F: Fn(&I::Item) -> bool,
{
    iters::Filtered::from(iter, predicate)
}

/// Returns the number of elements present in the given iterator.
pub fn length<I: Iterator>(iter: I) -> usize {
    let mut len = 0;

    for _ in iter {
        len += 1;
    }

    len
}

/// Returns an iterator of the results of applying `function(item)`
/// on all iter items.
pub fn map<I, F, U>(iter: I, function: F) -> impl Iterator<Item = U>
where
    I: Iterator,
    F: Fn(I::Item) -> U,
{
    iters::Mapper::from(iter, function)
}

/// Reduces the given iterator from left to right (or front to back),
/// applying the given function at each step of the operation. Treats
/// the initial value as the accumulated value seen by the first
/// element of the iterator.
pub fn foldl<I, F, U>(iter: I, initial: U, function: F) -> U
where
    I: Iterator,
    F: Fn(U, I::Item) -> U,
{
    let mut result = initial;

    for item in iter {
        result = function(result, item);
    }

    result
}

/// Reduces the given iterator from right to left (or back to front),
/// applying the given function at each step of the operation.
/// Treats the initial value as the accumulated value seen by the
/// first element of the iterator. This operation is impossible if
/// the iterator is not double-ended.
pub fn foldr<I, F, U>(iter: I, initial: U, function: F) -> U
where
    I: DoubleEndedIterator,
    F: Fn(U, I::Item) -> U,
{
    foldl(reverse(iter), initial, function)
}

/// Returns an iterator with all the original items, but in reverse order.
/// This operation is impossible if the iterator is not double-ended.
pub fn reverse<I: DoubleEndedIterator>(iter: I) -> impl Iterator<Item = I::Item> {
    iters::Reversed::from(iter)
}
