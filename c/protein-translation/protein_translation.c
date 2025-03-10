#include "protein_translation.h"
#include <math.h>
#include <stdio.h>
#include <string.h>

// Size of a codon
const size_t CODON_SIZE = 3;

// Stores the possible results of a codon translation
typedef struct {
  bool is_protein;
  bool is_stop;
  protein_t protein;
} codon_translation_t;

// Obtains the codon (group of 3 nucleotides) given by the passed index
void codon(const char *const rna, size_t index, char *output);

// Gets the translation result of the passed codon.
codon_translation_t translate_codon(const char *const codon);

proteins_t proteins(const char *const rna) {
  const size_t nucleotide_count = strlen(rna);
  const size_t codons_count =
      (size_t)ceil((double)(nucleotide_count) / CODON_SIZE);

  proteins_t result;
  result.count = 0;
  result.valid = true;
  memset(result.proteins, 0, sizeof(result.proteins));

  char current_codon[CODON_SIZE + 1];
  memset(current_codon, '\0', CODON_SIZE + 1);

  for (size_t i = 0; result.valid && i < codons_count; i++) {
    codon(rna, i, current_codon);
    codon_translation_t translation = translate_codon(current_codon);

    if (translation.is_stop) {
      break;
    } else if (translation.is_protein) {
      result.proteins[result.count++] = translation.protein;
    } else {
      result.valid = false;
    }
  }

  return result;
}

void codon(const char *const rna, size_t index, char *output) {
  const size_t start = (index * CODON_SIZE);
  const size_t len = strlen(rna);

  for (size_t i = 0; i < CODON_SIZE; i++) {
    if (start + i < len) {
      output[i] = rna[start + i];
    } else {
      output[i] = '\0';
    }
  }
}

codon_translation_t translate_codon(const char *const codon) {
  static const char *proteins_codons[] = {"AUG", "UUU", "UUC", "UUA", "UUG",
                                          "UCU", "UCC", "UCA", "UCG", "UAU",
                                          "UAC", "UGU", "UGC", "UGG"};
  static const size_t proteins_codons_count =
      sizeof(proteins_codons) / sizeof(proteins_codons[0]);
  static const protein_t proteins[] = {
      Methionine, Phenylalanine, Phenylalanine, Leucine,   Leucine,
      Serine,     Serine,        Serine,        Serine,    Tyrosine,
      Tyrosine,   Cysteine,      Cysteine,      Tryptophan};

  static const char *stop_codons[] = {"UAA", "UAG", "UGA"};
  static const size_t stop_codons_count =
      sizeof(stop_codons) / sizeof(stop_codons[0]);

  codon_translation_t translation = {
      .is_stop = false, .is_protein = false, .protein = 0};

  for (size_t i = 0; i < proteins_codons_count; i++) {
    if (!strcmp(codon, proteins_codons[i])) {

      translation.is_protein = true;
      translation.protein = proteins[i];
      return translation;
    }
  }
  for (size_t i = 0; i < stop_codons_count; i++) {
    if (!strcmp(codon, stop_codons[i])) {
      translation.is_stop = true;
      return translation;
    }
  }
  return translation;
}