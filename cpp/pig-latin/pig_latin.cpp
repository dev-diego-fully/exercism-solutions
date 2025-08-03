#include "pig_latin.h"

#include <optional>
#include <regex>

namespace pig_latin {

/**
 * @var WORD_PATTERN
 * @brief A regular expression to find words (sequences of lowercase letters).
 */
const std::regex WORD_PATTERN(R"(\b[a-z]+\b)");

/**
 * @typedef rule_apply_result_t
 * @brief A type alias for an optional string, representing the result of a
 * translation rule.
 *
 * It is `std::nullopt` if the rule doesn't apply, or contains the translated
 * word if it does.
 */
using rule_apply_result_t = std::optional<std::string>;
/**
 * @typedef rule_t
 * @brief A type alias for a function that implements a Pig Latin translation
 * rule.
 *
 * The function takes a word and returns a `rule_apply_result_t`.
 */
using rule_t = std::function<rule_apply_result_t(const std::string &text)>;

std::string translate_word(const std::string &word);
std::sregex_iterator words(const std::string &text);
rule_apply_result_t rule_1(const std::string &text);
rule_apply_result_t rule_2(const std::string &text);
rule_apply_result_t rule_3(const std::string &text);
rule_apply_result_t rule_4(const std::string &text);

/**
 * @brief Translates an English text to Pig Latin.
 *
 * This function iterates through each word in the input text and applies
 * `translate_word` to it, concatenating the results to form the final
 * translated text.
 *
 * @param text The input text to be translated.
 * @return The translated text in Pig Latin.
 */
std::string translate(const std::string &text) {
  std::string translation;

  for (std::sregex_iterator it = words(text), end; it != end; it++) {
    const auto word = it->str();
    if (!translation.empty()) {
      translation.append(" ");
    }
    translation.append(translate_word(word));
  }

  return translation;
}

/**
 * @brief Creates a regex iterator to find all words in a text.
 *
 * @param text The text to search.
 * @return An `std::sregex_iterator` that points to the first word.
 */
std::sregex_iterator words(const std::string &text) {
  return std::sregex_iterator(text.begin(), text.end(), WORD_PATTERN);
}

/**
 * @brief Translates a single word to Pig Latin by applying a set of rules.
 *
 * The rules are tried in a specific order until one of them successfully
 * translates the word.
 *
 * @param word The word to be translated.
 * @return The translated word if a rule is matched, otherwise the original
 * word.
 */
std::string translate_word(const std::string &word) {
  const std::vector<rule_t> rules = {rule_1, rule_4, rule_3, rule_2};

  for (rule_t rule : rules) {
    const rule_apply_result_t result_of_applying = rule(word);

    if (result_of_applying != std::nullopt) {
      return result_of_applying.value();
    }
  }

  return word;
}

/**
 * @brief Implements Rule 1 of Pig Latin: words starting with vowels, "xr", or
 * "yt".
 *
 * @param text The word to check.
 * @return The translated word with "ay" appended, or `std::nullopt` if the rule
 * doesn't apply.
 */
rule_apply_result_t rule_1(const std::string &text) {
  const std::regex pattern(R"(\b(?:[aeiou]+|xr|yt).*\b)");

  if (!std::regex_match(text, pattern)) {
    return std::nullopt;
  }
  return std::optional(text + "ay");
}

/**
 * @brief Implements Rule 2 of Pig Latin: words starting with one or more
 * consonants.
 *
 * Moves the initial consonant cluster to the end and appends "ay".
 *
 * @param text The word to check.
 * @return The translated word, or `std::nullopt` if the rule doesn't apply.
 */
rule_apply_result_t rule_2(const std::string &text) {
  const std::regex pattern(R"(\b([bcdfghjklmnpqrstvwxyz]+)(.*)\b)");

  std::smatch match;
  if (!std::regex_search(text, match, pattern)) {
    return std::nullopt;
  }

  const std::string left = match[1];
  const std::string right = match[2];

  return std::optional(right + left + "ay");
}

/**
 * @brief Implements Rule 3 of Pig Latin: words starting with a consonant
 * followed by "qu".
 *
 * Moves the consonant cluster including "qu" to the end and appends "ay".
 *
 * @param text The word to check.
 * @return The translated word, or `std::nullopt` if the rule doesn't apply.
 */
rule_apply_result_t rule_3(const std::string &text) {
  const std::regex pattern(R"(\b([bcdfghjklmnpqrstvwxyz]*qu)(.*)\b)");

  std::smatch match;
  if (!std::regex_search(text, match, pattern)) {
    return std::nullopt;
  }

  const std::string left = match[1];
  const std::string right = match[2];

  return std::optional(right + left + "ay");
}

/**
 * @brief Implements Rule 4 of Pig Latin: words with 'y' as the second letter in
 * a consonant cluster.
 *
 * @param text The word to check.
 * @return The translated word, or `std::nullopt` if the rule doesn't apply.
 */
rule_apply_result_t rule_4(const std::string &text) {
  const std::regex pattern(R"(\b([bcdfghjklmnpqrstvwxyz]+)(y.*)\b)");
  std::smatch match;

  if (!std::regex_search(text, match, pattern)) {
    return std::nullopt;
  }

  const std::string left = match[1];
  const std::string right = match[2];

  return std::optional(right + left + "ay");
}

}  // namespace pig_latin