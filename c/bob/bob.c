#include "bob.h"

#include <ctype.h>
#include <stdbool.h>
#include <string.h>

typedef enum {
  QUESTION,
  SCREAM,
  SCREAMING_QUESTION,
  SILENCE,
  DEFAULT
} message_types_t;

const char *BOB_RESPONSES[] = {"Sure.", "Whoa, chill out!",
                               "Calm down, I know what I'm doing!",
                               "Fine. Be that way!", "Whatever."};

bool is_yell(const char *greeting);
bool is_question(const char *greeting);
bool is_silence(const char *greeting);
bool some(const char *str, int (*checker)(int));
int not_space(int chr);

// Sends a message to Bob and returns his response.
const char *hey_bob(const char *greeting) {
  if (is_silence(greeting)) {
    return BOB_RESPONSES[SILENCE];
  }

  const bool is_questioning = is_question(greeting);
  if (is_questioning != is_yell(greeting)) {
    return BOB_RESPONSES[is_questioning ? QUESTION : SCREAM];
  }
  return BOB_RESPONSES[is_questioning ? SCREAMING_QUESTION : DEFAULT];
}

// Check if the user is shouting in the message sent to Bob
bool is_yell(const char *greeting) {
  return some(greeting, isupper) && !some(greeting, islower);
}

// Checks if the user is asking Bob a question in the message sent to him.
bool is_question(const char *greeting) {
  const size_t len = strlen(greeting);

  for (size_t i = 0; i < len; i++) {
    const char current = greeting[len - i - 1];
    if (current == '?') {
      return true;
    }
    if (!isspace(current)) {
      return false;
    }
  }

  return false;
}

// Checks if the message sent to Bob by the user is just silence
bool is_silence(const char *greeting) { return !some(greeting, not_space); }

// Checks if one of the characters in the string returns positive for the given
// function. Stops when it finds the first true.
bool some(const char *str, int (*checker)(int)) {
  const size_t len = strlen(str);

  for (size_t i = 0; i < len; i++) {
    if (checker(str[i])) {
      return true;
    }
  }

  return false;
}

// Checks if the passed value does not match a whitespace.
int not_space(int chr) { return !isspace(chr); }