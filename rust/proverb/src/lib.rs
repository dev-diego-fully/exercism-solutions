pub fn build_proverb(list: &[&str]) -> String {
    if list.is_empty() {
        return String::new();
    }
    let mut messages = get_for_want_was_lost_lines(list);
    messages.push(line_all_for_want(list[0]));
    messages.join("\n")
}

fn line_for_want_was_lost(wanted: &str, losted: &str) -> String {
    format!("For want of a {wanted} the {losted} was lost.")
}

fn line_all_for_want(wanted: &str) -> String {
    format!("And all for the want of a {wanted}.")
}

fn get_for_want_was_lost_lines(list: &[&str]) -> Vec<String> {
    get_wanteds(list)
        .zip(get_losts(list))
        .map(|(wanted, losted)| line_for_want_was_lost(wanted, losted))
        .collect()
}

fn get_wanteds<'a>(list: &'a [&'a str]) -> impl Iterator<Item = &'a str> {
    list.iter().take(list.len() - 1).copied()
}

fn get_losts<'a>(list: &'a [&'a str]) -> impl Iterator<Item = &'a str> {
    list.iter().cycle().skip(1).take(list.len() - 1).copied()
}
