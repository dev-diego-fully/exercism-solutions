#include "nucleotide_count.h"


namespace nucleotide_count {

bool is_nucleotide(const char chr) {
    switch (chr) {
        case 'A':
        case 'G':
        case 'T':
        case 'C':
            return true;
        default:
            return false;
    }
}

std::map<char, int> count(const std::string dna_strand) {
    std::map<char, int> counts{
        {'A', 0}, {'C', 0}, {'G', 0}, {'T', 0}
    };

    for(const char c: dna_strand) {
        if(!is_nucleotide(c)) {
            throw std::invalid_argument("");
        }
        counts[c]++;
    }

    return counts;
}

}  // namespace nucleotide_count
