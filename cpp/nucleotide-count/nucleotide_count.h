#if !defined(NUCLEOTIDE_COUNT_H)
#define NUCLEOTIDE_COUNT_H

#include <map>
#include <string>
#include <stdexcept>

namespace nucleotide_count {

std::map<char, int> count(const std::string dna_strand);

}  // namespace nucleotide_count

#endif // NUCLEOTIDE_COUNT_H