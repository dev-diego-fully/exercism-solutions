#include "rna_transcription.h"

namespace rna_transcription {

char to_rna(char dna) {
  switch (dna) {
  case 'C':
    return 'G';
  case 'G':
    return 'C';
  case 'T':
    return 'A';
  case 'A':
    return 'U';
  default:
    return '?';
  }
}

std::string to_rna(const std::string dna) {
  std::string rna = dna;
  for (size_t i = 0; i < rna.length(); i++) {
    rna[i] = to_rna(rna[i]);
  }
  return rna;
}

} // namespace rna_transcription
