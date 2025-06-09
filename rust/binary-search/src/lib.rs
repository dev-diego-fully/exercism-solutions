/// Performs an iterative binary search on an array-like object or vector
/// to find the index of a given element's value.
///
/// Returns `Some(index)` if the element is found at the specified `index`,
/// otherwise returns `None`.
pub fn find<A, T>(array: A, key: T) -> Option<usize>
where
    A: AsRef<[T]>,
    T: PartialEq + PartialOrd + Copy,
{
    let arr = array.as_ref();
    let (mut bot, mut top) = initial_bounds(arr)?;

    while bot <= top {
        let (mid, element) = mid_of(arr, bot, top);

        if *element == key {
            return Some(mid);
        }
        (bot, top) = update_bounds(bot, top, mid, *element > key)?;
    }

    None
}

/// Calculates the middle index of a slice between `bot` (lower bound) and `top` (upper bound).
///
/// Returns a tuple containing the **middle index** and a **reference to the element** at that index.
fn mid_of<T>(array: &[T], bot: usize, top: usize) -> (usize, &T) {
    if bot == top {
        (bot, &array[bot])
    } else {
        let mid = (bot + top).div_ceil(2);
        (mid, &array[mid])
    }
}

/// Adjusts the search bounds (`bot` and `top`) based on the comparison of the `mid` element with the `key`.
///
/// Takes the current `bot`, `top`, `mid` index, and an `is_greater` flag.
/// If `is_greater` is true, the `key` is considered greater than the element at `mid`,
/// narrowing the search to the lower half. Otherwise, the `key` is considered smaller,
/// narrowing the search to the upper half.
///
/// Returns `Some((new_bot, new_top))` with the updated bounds.
/// Returns `None` if `mid` is equal to `bot`, indicating that no further narrowing is possible
/// and the search has concluded (element not found in this segment).
fn update_bounds(bot: usize, top: usize, mid: usize, is_greater: bool) -> Option<(usize, usize)> {
    if mid == bot {
        None
    } else if is_greater {
        Some((bot, mid - 1))
    } else {
        Some((mid + 1, top))
    }
}

/// Initializes the lower (`bot`) and upper (`top`) bounds for a given slice.
///
/// Returns `Some((0, len - 1))` if the slice is not empty, representing the initial bounds.
/// Returns `None` if the slice is empty, indicating that a search cannot be performed.
fn initial_bounds<T>(array: &[T]) -> Option<(usize, usize)> {
    match array.len() {
        0 => None,
        len => Some((0, len - 1)),
    }
}
