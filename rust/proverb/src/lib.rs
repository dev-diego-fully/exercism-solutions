/// Returns a string containing the proverb constructed from the given
/// list of items.
///
/// For each element, it says that because it "wanted"
/// the next element, it was lost.
///
/// Finally, it says "all for wanted"
/// the first element.
pub fn build_proverb(list: &[&str]) -> String {
    if list.is_empty() {
        return String::new();
    }
    let mut messages = get_for_want_was_lost_lines(list);
    messages.push(line_all_for_want(list[0]));
    messages.join("\n")
}

/// Returns a line in the format of the main lines of the proverb.
/// In this one, it says
///
/// "For want of a `wanted` the `lost` was lost."
fn line_for_want_was_lost(wanted: &str, losted: &str) -> String {
    format!("For want of a {wanted} the {losted} was lost.")
}

/// Returns a line in the format of the final line of the proverb.
/// It will say something like:
///
/// "And all for the want of a `wanted`."
fn line_all_for_want(wanted: &str) -> String {
    format!("And all for the want of a {wanted}.")
}

/// Returns an array containing one line of the proverb in line-major format.
///
/// It will have something like (for each index i) a line similar to:
///
/// "For want of a `list[i]` the `list[i+1]` was lost."
fn get_for_want_was_lost_lines(list: &[&str]) -> Vec<String> {
    get_wanteds(list)
        .zip(get_losts(list))
        .map(|(wanted, losted)| line_for_want_was_lost(wanted, losted))
        .collect()
}

/// Returns, from the given list, an iterator containing all the elements
/// in the order they appear in a main line as a "wanted" object.
fn get_wanteds<'a>(list: &'a [&'a str]) -> impl Iterator<Item = &'a str> {
    list.iter().take(list.len() - 1).copied()
}

/// Returns, from the given list, an iterator containing the elements in the
/// order in which they appear in a main line as a "lost" object.
fn get_losts<'a>(list: &'a [&'a str]) -> impl Iterator<Item = &'a str> {
    list.iter().cycle().skip(1).take(list.len() - 1).copied()
}
