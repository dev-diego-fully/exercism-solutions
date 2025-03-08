/**
 * @file reverse_string.h
 * @brief Header for string reversal functionality
 */

#ifndef REVERSE_STRING_H
#define REVERSE_STRING_H

/**
 * @brief Reverses a null-terminated string
 * 
 * Creates a new dynamically allocated string containing characters 
 * in reverse order from the input string.
 * 
 * @param value The string to reverse. If NULL is passed, returns NULL.
 * @return Pointer to the reversed string (must be freed by caller),
 *         or NULL if memory allocation fails
 * @warning Caller is responsible for freeing the returned pointer
 */
char *reverse(const char *value);

#endif