#include "matching_brackets.h"

#include <stdlib.h>
#include <string.h>

// Represents the possible bracket pair types.
typedef enum { BRACKET, BRACE, PARENTHESES } bracket_t;

// Represents a bracket that may or may not be present
typedef struct {
  bool present;
  bracket_t value;
} optional_bracket_t;

// A stack for processing brackets
typedef struct {
  size_t max_length;
  size_t count;
  bracket_t stack[];
} bracket_stack_t;

bool process_caracter(bracket_stack_t *stack, char caracter);
bool is_empty(const bracket_stack_t *stack);
bool push(bracket_stack_t *stack, bracket_t bracket);
bool try_pop_bracket(bracket_stack_t *stack, bracket_t bracket);

optional_bracket_t pop(bracket_stack_t *stack);
bracket_stack_t *new_stack(size_t len);
void destroy_stack(bracket_stack_t *stack);

// Check that all brackets in the string are correctly paired.
bool is_paired(const char *input) {
  if (!input) {
    return false;
  }

  const size_t len = strlen(input);
  bracket_stack_t *stack = new_stack(len);

  if (!stack) {
    return false;
  }

  bool succeed = true;
  for (size_t i = 0; succeed && i < len; i++) {
    succeed = process_caracter(stack, input[i]);
  }

  succeed = succeed && is_empty(stack);
  destroy_stack(stack);

  return succeed;
}

// Processes the passed character, if it is valid, adding or removing its result
// from the passed stack.
bool process_caracter(bracket_stack_t *stack, char caracter) {
  switch (caracter) {
  case '[':
    return push(stack, BRACKET);
  case '{':
    return push(stack, BRACE);
  case '(':
    return push(stack, PARENTHESES);
  case ']':
    return try_pop_bracket(stack, BRACKET);
  case '}':
    return try_pop_bracket(stack, BRACE);
  case ')':
    return try_pop_bracket(stack, PARENTHESES);
  default:
    return true;
  }
}

// Checks if the passed stack is empty.
bool is_empty(const bracket_stack_t *stack) { return stack->count == 0; }

// Adds the passed bracket to the top of the passed stack.
bool push(bracket_stack_t *stack, bracket_t bracket) {
  if (stack->count < stack->max_length) {
    stack->stack[stack->count++] = bracket;
    return true;
  }
  return false;
}

// Removes the bracket from the top of the stack and returns whether it is the
// desired one.
bool try_pop_bracket(bracket_stack_t *stack, bracket_t bracket) {
  const optional_bracket_t popped = pop(stack);
  return popped.present && popped.value == bracket;
}

// Removes and returns the bracket on top of the stack, if any.
optional_bracket_t pop(bracket_stack_t *stack) {
  if (is_empty(stack)) {
    return (optional_bracket_t){.present = false, .value = 0};
  }
  return (optional_bracket_t){.present = true,
                              .value = stack->stack[--stack->count]};
}

// Creates an empty bracket stack with the desired size.
bracket_stack_t *new_stack(size_t len) {
  const size_t stack_size = sizeof(bracket_stack_t) + sizeof(bracket_t) * len;
  bracket_stack_t *stack = calloc(1, stack_size);

  if (stack) {
    stack->max_length = len;
  }

  return stack;
}

// Destroys the passed bracket stack (ideally one created with
// new_bracket_stack)
void destroy_stack(bracket_stack_t *stack) { free(stack); }