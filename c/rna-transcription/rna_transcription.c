#include "rna_transcription.h"

char rna_complement(const char nucleotide);

char *to_rna(const char *dna) {
  char *translated = (char *)calloc(strlen(dna), sizeof(char));
  for (size_t i = 0; i < strlen(dna); i++) {
    translated[i] = rna_complement(dna[i]);
  }
  return translated;
}

char rna_complement(const char nucleotide) {
  switch (nucleotide) {
  case 'A':
    return 'U';
  case 'T':
    return 'A';
  case 'C':
    return 'G';
  case 'G':
    return 'C';
  default:
    return ' ';
  }
}