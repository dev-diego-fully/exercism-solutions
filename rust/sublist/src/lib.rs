/// Type to represent the relationship between two lists.
#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

/// Returns a Comparasion reporting the relationship between the two given lists.
pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    match (
        is_sublist(first_list, second_list),
        is_sublist(second_list, first_list),
    ) {
        (true, true) => Comparison::Equal,
        (true, false) => Comparison::Sublist,
        (false, true) => Comparison::Superlist,
        (false, false) => Comparison::Unequal,
    }
}

/// Returns whether or not the first list is a sublist of the second list.
fn is_sublist(first: &[i32], second: &[i32]) -> bool {
    match (first.len(), second.len()) {
        (0, _) => true,
        (_, 0) => false,
        (lf, ls) if lf > ls => false,
        (lf, _) => second.windows(lf).any(|w| w == first),
    }
}
