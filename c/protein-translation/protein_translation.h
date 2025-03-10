#ifndef PROTEIN_TRANSLATION_H
#define PROTEIN_TRANSLATION_H

#include <stdbool.h>
#include <stddef.h>

#define MAX_PROTEINS 10

// Represents the possible proteins in the translation of codons
typedef enum {
  Methionine,
  Phenylalanine,
  Leucine,
  Serine,
  Tyrosine,
  Cysteine,
  Tryptophan,
} protein_t;

// Represents the result of the translation of a strand of rna
typedef struct {
  bool valid;
  size_t count;
  protein_t proteins[MAX_PROTEINS];
} proteins_t;

// Translates the past rna strand. Maximum of 10 proteins.
proteins_t proteins(const char *const rna);

#endif
