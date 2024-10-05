#pragma once
#if !defined(PROTEIN_TRANSLATION_H)
#define PROTEIN_TRANSLATION_H

#include <string>
#include <vector>
#include <cmath>
#include <unordered_map>

namespace protein_translation {

using Protein = std::string;
using Codon = std::string;
using RNA = std::string;
using CodificationMap = std::unordered_map<Codon, Protein>;

std::vector<Protein> proteins( RNA rna );

}  // namespace protein_translation

#endif // PROTEIN_TRANSLATION_H
