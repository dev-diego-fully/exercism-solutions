/// Sends a message to Bob and returns his response
pub fn reply(message: &str) -> &str {
    MessageType::from(message).bob_response()
}

/// Categories of messages that Bob can recognize.
enum MessageType {
    Silence,
    Question,
    Yell,
    YellingQuestion,
    Others,
}

impl MessageType {
    // Gets the message type of the given message.
    fn from(message: &str) -> Self {
        match (
            Self::is_silence(message),
            Self::is_question(message),
            Self::is_yell(message),
        ) {
            (true, _, _) => Self::Silence,
            (_, true, true) => Self::YellingQuestion,
            (_, true, _) => Self::Question,
            (_, _, true) => Self::Yell,
            (_, _, _) => Self::Others,
        }
    }

    /// Get Bob's scheduled response for the respective message type
    fn bob_response<'a>(&self) -> &'a str {
        match self {
            Self::Silence => "Fine. Be that way!",
            Self::Question => "Sure.",
            Self::Yell => "Whoa, chill out!",
            Self::YellingQuestion => "Calm down, I know what I'm doing!",
            Self::Others => "Whatever.",
        }
    }

    /// Checks if the given message is a question.
    fn is_question(message: &str) -> bool {
        let last_non_space = message.chars().rev().find(|c| !char::is_whitespace(*c));
        matches!(last_non_space, Some(v) if v == '?')
    }

    /// Checks if the given message is just silence.
    fn is_silence(message: &str) -> bool {
        message.chars().all(char::is_whitespace)
    }

    /// Checks if the given message is a yell
    fn is_yell(message: &str) -> bool {
        let some_upper = message.chars().any(char::is_uppercase);
        let no_lowers = message.chars().all(|c| !char::is_lowercase(c));
        some_upper && no_lowers
    }
}
