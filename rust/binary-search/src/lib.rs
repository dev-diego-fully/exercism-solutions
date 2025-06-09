pub fn find(array: &[i32], key: i32) -> Option<usize> {
    let (mut bot, mut top) = get_bounds(array)?;

    while bot <= top {
        let (mid, element) = mid_of(array, bot, top);

        if *element == key {
            return Some(mid);
        }
        (bot, top) = update_bounds(bot, top, mid, *element > key)?;
    }

    None
}

fn mid_of<T>(array: &[T], bot: usize, top: usize) -> (usize, &T) {
    if bot == top {
        (bot, &array[bot])
    } else {
        let mid = (bot + top) / 2;
        (mid, &array[mid])
    }
}

fn update_bounds(bot: usize, top: usize, mid: usize, is_greater: bool) -> Option<(usize, usize)> {
    if mid == bot {
        None
    } else if is_greater {
        Some((bot, mid - 1))
    } else {
        Some((mid + 1, top))
    }
}

fn get_bounds<T>(array: &[T]) -> Option<(usize, usize)> {
    match array.len() {
        0 => None,
        len => Some((0, len - 1)),
    }
}
