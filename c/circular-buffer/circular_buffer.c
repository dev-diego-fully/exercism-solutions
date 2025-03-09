#include "circular_buffer.h"

#include <errno.h>
#include <stdlib.h>
#include <string.h>

// Checks if the buffer is full. Does not check for NULL.
bool is_full(circular_buffer_t *buffer);

// Adds the element at the current position in the buffer and adjusts the size
// accordingly. Does not check for NULL.
void push(circular_buffer_t *buffer, buffer_value_t element);

// Advances the reader position circularly
void advance_reader(circular_buffer_t *buffer);

// Advances the writing position circularly
void advance_writer(circular_buffer_t *buffer);

// Publics Implementations

// Adds element to the buffer, fails if the buffer is full
bool write(circular_buffer_t *buffer, buffer_value_t element) {
  if (!buffer) {
    return EXIT_FAILURE;
  }
  if (is_full(buffer)) {
    errno = ENOBUFS;
    return EXIT_FAILURE;
  }

  push(buffer, element);
  return EXIT_SUCCESS;
}

// Adds element to the buffer, deleting the oldest element if it is full.
bool overwrite(circular_buffer_t *buffer, buffer_value_t element) {
  if (!buffer) {
    return EXIT_FAILURE;
  }

  push(buffer, element);

  return EXIT_SUCCESS;
}

// Reads an element from the buffer and removes it. The read value is stored in
// output
bool read(circular_buffer_t *buffer, buffer_value_t *output) {
  if (buffer && buffer->elements_count > 0) {
    *output = buffer->elements[buffer->reader_position];
    advance_reader(buffer);
    buffer->elements_count--;
    return EXIT_SUCCESS;
  }

  errno = ENODATA;
  return EXIT_FAILURE;
}

// Leaves the buffer empty.
void clear_buffer(circular_buffer_t *buffer) {
  if (buffer) {
    buffer->elements_count = 0;
  }
}
// Creates a new buffer with the given capacity. Created buffer needs to be
// manually destroyed afterwards.
circular_buffer_t *new_circular_buffer(size_t capacity) {
  const size_t circular_buffer_t_size =
      sizeof(circular_buffer_t) + capacity * sizeof(size_t);

  circular_buffer_t *buffer = malloc(circular_buffer_t_size);
  if (!buffer) {
    return NULL;
  }
  memset(buffer, 0, circular_buffer_t_size);
  buffer->buffer_size = capacity;

  return buffer;
}

// Destroys the passed buffer (ideally one created by new_circular_buffer)
void delete_buffer(circular_buffer_t *buffer) { free(buffer); }

// Privates Implementations

bool is_full(circular_buffer_t *buffer) {
  return buffer->elements_count >= buffer->buffer_size;
}

void push(circular_buffer_t *buffer, buffer_value_t element) {
  buffer->elements[buffer->writer_position] = element;
  advance_writer(buffer);

  if (is_full(buffer)) {
    advance_reader(buffer);
  } else {
    buffer->elements_count++;
  }
}

void advance_reader(circular_buffer_t *buffer) {
  buffer->reader_position++;
  buffer->reader_position %= buffer->buffer_size;
}

void advance_writer(circular_buffer_t *buffer) {
  buffer->writer_position++;
  buffer->writer_position %= buffer->buffer_size;
}