/// Checks whether all brackets in the text are correctly opened and closed.
pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack = Vec::new();
    let all_inserted = Bracket::parse_str(string)
        .iter()
        .all(|b| treat_bracket(&mut stack, *b));
    all_inserted && stack.is_empty()
}

/// Handles the opening or closing of the provided bracket, as long as
/// it is valid in the current stack state. Returns true on success.
fn treat_bracket(stack: &mut Vec<BracketType>, bracket: Bracket) -> bool {
    match (bracket, stack.last()) {
        (Bracket::Open(b), _) => {
            stack.push(b);
            true
        }
        (Bracket::Close(a), Some(b)) if a == *b => {
            stack.pop();
            true
        }
        _ => false,
    }
}

/// Represents the possible brackets. They are separated into opening
/// and closing.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Bracket {
    Open(BracketType),
    Close(BracketType),
}

impl Bracket {
    fn parse(c: char) -> Option<Self> {
        match c {
            '{' | '[' | '(' => Some(Bracket::Open(BracketType::from(c).unwrap())),
            '}' | ']' | ')' => Some(Bracket::Close(BracketType::from(c).unwrap())),
            _ => None,
        }
    }

    fn parse_str(s: &str) -> Vec<Self> {
        s.chars().filter_map(Bracket::parse).collect()
    }
}

/// Represents the possible types of brackets { } | [ ] | ( )
#[derive(Clone, Copy, PartialEq, Eq)]
enum BracketType {
    Bracket,
    Bracer,
    Paretheses,
}

impl BracketType {
    fn from(c: char) -> Option<Self> {
        match c {
            '{' | '}' => Some(BracketType::Bracer),
            '[' | ']' => Some(BracketType::Bracket),
            '(' | ')' => Some(BracketType::Paretheses),
            _ => None,
        }
    }
}
