/**
 * @file reverse_string.c
 * @brief Implementation of string reversal functions
 */
#include "reverse_string.h"
#include <stdlib.h>
#include <string.h>

/**
 * @brief Reverse a string and return newly allocated result
 * 
 * Implementation details:
 * - Handles NULL input gracefully
 * - Uses calloc for memory allocation (auto-null-terminated)
 * - Direct character-by-character reversal
 * 
 * @param value Input string to reverse
 * @return char* Reversed string or NULL on failure
 * 
 * @note Complexity: O(n) time and space
 * @example
 *   char* reversed = reverse("hello");
 *   printf("%s", reversed); // prints "olleh"
 *   free(reversed);
 */
char *reverse(const char *value)
{   
    if(value == NULL) {
        return NULL;
    }

    const size_t len = strlen(value);
    char* reversed = (char*)calloc(len+1, sizeof(char));

    if(reversed == NULL) {
        return NULL;
    }

    for(size_t i = 0; i < len; i++) {
        reversed[i] = value[len-i-1];
    }

    return reversed;
}