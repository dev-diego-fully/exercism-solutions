#include "two_fer.h"

void two_fer(char *buffer, const char *name) {
  const char format[] = "One for %s, one for me.";
  const char unknown_name_pronoun[] = "you";
  sprintf(buffer, format, name != NULL ? name : unknown_name_pronoun);
}