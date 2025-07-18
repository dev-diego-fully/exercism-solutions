//! A simple Pig Latin translator.
//!
//! This module provides functions to translate English words and sentences into Pig Latin
//! following a specific set of rules.

use regex::Regex;

/// Translates a given input string (sentence) into Pig Latin.
///
/// This function splits the input by ASCII whitespace, translates each word individually,
/// and then joins them back into a single string.
///
/// # Arguments
///
/// * `input` - The string slice to be translated.
///
/// # Returns
///
/// A `String` containing the Pig Latin translation of the input.
pub fn translate(input: &str) -> String {
    input
        .split_ascii_whitespace()
        .map(translate_word)
        .collect::<Vec<String>>()
        .join(" ")
}

/// Translates a single word into Pig Latin based on a set of rules.
///
/// It attempts to apply translation rules in a specific order:
/// Rule 1 (vowel start), Rule 3 (consonant + 'qu' cluster), Rule 4 (consonant + 'y' cluster),
/// and finally Rule 2 (general consonant cluster).
/// If no rule applies, the original word is returned.
///
/// # Arguments
///
/// * `word` - The string slice representing the word to translate.
///
/// # Returns
///
/// A `String` containing the Pig Latin translation of the word.
fn translate_word(word: &str) -> String {
    for rule in [apply_rule_1, apply_rule_3, apply_rule_4, apply_rule_2] {
        if let Some(translation) = rule(word) {
            return translation;
        }
    }
    word.to_owned()
}

/// Applies Rule 1: Words starting with vowels, "xr", or "yt" just add "ay" to the end.
///
/// # Arguments
///
/// * `word` - The word to apply the rule to.
///
/// # Returns
///
/// * `Some(String)` if the rule applies and the word is translated.
/// * `None` if the rule does not apply to the word.
fn apply_rule_1(word: &str) -> Option<String> {
    let pattern = Regex::new(r"\b(?:[aeiou]+|xr|yt)(?:.*)\b").unwrap();

    if !pattern.is_match(word) {
        return None;
    }

    Some(String::from(word) + "ay")
}

/// Applies Rule 2: Words starting with one or more consonants move the consonant cluster
/// to the end and add "ay".
///
/// This rule is a general fallback for consonant-starting words not covered by other rules.
///
/// # Arguments
///
/// * `word` - The word to apply the rule to.
///
/// # Returns
///
/// * `Some(String)` if the rule applies and the word is translated.
/// * `None` if the rule does not apply (e.g., word doesn't start with a consonant cluster).
fn apply_rule_2(word: &str) -> Option<String> {
    let pattern = Regex::new(r"\b([bcdfghjklmnpqrstvwxyz]+)(.*)\b").unwrap();
    let caps = pattern.captures(word)?;

    let consonants = &caps[1];
    let rem = &caps[2];

    Some(rem.to_owned() + consonants + "ay")
}

/// Applies Rule 3: Words starting with a consonant cluster followed by "qu"
/// move the entire cluster (including "qu") to the end and add "ay".
///
/// # Arguments
///
/// * `word` - The word to apply the rule to.
///
/// # Returns
///
/// * `Some(String)` if the rule applies and the word is translated.
/// * `None` if the rule does not apply.
fn apply_rule_3(word: &str) -> Option<String> {
    let pattern = Regex::new(r"\b([bcdfghjklmnpqrstvwxyz]*qu)(.*)\b").unwrap();
    let caps = pattern.captures(word)?;

    let left = &caps[1];
    let right = &caps[2];

    Some(right.to_owned() + left + "ay")
}

/// Applies Rule 4: Words starting with a consonant cluster followed by 'y'
/// move the consonant cluster (before 'y') to the end and add "ay".
///
/// # Arguments
///
/// * `word` - The word to apply the rule to.
///
/// # Returns
///
/// * `Some(String)` if the rule applies and the word is translated.
/// * `None` if the rule does not apply.
fn apply_rule_4(word: &str) -> Option<String> {
    let pattern = Regex::new(r"\b([bcdfghjklmnpqrstvwxyz]+)(y.*)\b").unwrap();
    let caps = pattern.captures(word)?;

    let left = &caps[1];
    let right = &caps[2];

    Some(right.to_owned() + left + "ay")
}