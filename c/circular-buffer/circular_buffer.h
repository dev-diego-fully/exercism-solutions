#ifndef CIRCULAR_BUFFER_H
#define CIRCULAR_BUFFER_H

#include <stdbool.h>
#include <stddef.h>

typedef int buffer_value_t;

typedef struct {
  size_t reader_position;
  size_t writer_position;
  size_t buffer_size;
  size_t elements_count;
  buffer_value_t elements[];
} circular_buffer_t;

// Adds element to the buffer, fails if the buffer is full
bool write(circular_buffer_t *buffer, buffer_value_t value);

// Adds element to the buffer, deleting the oldest element if it is full.
bool overwrite(circular_buffer_t *buffer, buffer_value_t value);

// Reads an element from the buffer and removes it. The read value is stored in
// output
bool read(circular_buffer_t *buffer, buffer_value_t *output);

// Leaves the buffer empty.
void clear_buffer(circular_buffer_t *buffer);

// Creates a new buffer with the given capacity. Created buffer needs to be
// manually destroyed afterwards.
circular_buffer_t *new_circular_buffer(size_t capacity);

// Destroys the passed buffer (ideally one created by new_circular_buffer)
void delete_buffer(circular_buffer_t *buffer);

#endif
