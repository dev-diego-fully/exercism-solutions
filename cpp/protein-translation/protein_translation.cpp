#include "protein_translation.h"



namespace protein_translation {

CodificationMap default_codification_map() {
    return {
        {"AUG", "Methionine"},
        {"UUU", "Phenylalanine"},
        {"UUC", "Phenylalanine"},
        {"UUA", "Leucine"},
        {"UUG", "Leucine"},
        {"UCU", "Serine"},
        {"UCC", "Serine"},
        {"UCA", "Serine"},
        {"UCG", "Serine"},
        {"UAU", "Tyrosine"},
        {"UAC", "Tyrosine"},
        {"UGU", "Cysteine"},
        {"UGC", "Cysteine"},
        {"UGG", "Tryptophan"},
        {"UAA", "STOP"},
        {"UAG", "STOP"},
        {"UGA", "STOP"}
    };
}

template< typename T>
bool contains( const std::vector<T>& vec, T element ) {

    const int members_number = vec.size();

    for( int i = 0; i < members_number; i++ ) {

        if( vec.at( i ) == element )
            return true;

    }
    
    return false;

}

Protein protein( const Codon codon, const CodificationMap& codification_map ) {

    if( codification_map.find( codon ) != codification_map.end() )
        return codification_map.at( codon );
    
    return "STOP";

}

int codon_index( const int nth_codon ) {

    const int codon_len = 3;

    return (nth_codon - 1) * codon_len;

}

std::vector<Codon> split_in_codons( const RNA& rna ) {

    const int codon_len = 3;
    const int number_of_codons = std::floor( rna.size() / codon_len );
    std::vector<Codon> codons;

    for( int i = 1; i <= number_of_codons; i++ ) {

        const int codon_start = codon_index( i );
        const Codon codon = rna.substr( codon_start, codon_len );
        
        codons.push_back( codon );

    }

    return codons;

}

std::vector<Protein> proteins( const std::vector<Codon>& codons ) {

    const int number_of_codons = codons.size();
    std::vector<Protein> codifieds;
    const CodificationMap codification_map = default_codification_map();

    for( int i = 0; i < number_of_codons; i++ ) {

        const Codon current_codon = codons.at( i );
        const Protein codefied = protein( current_codon, codification_map );

        if( codefied == "STOP" )
            break;

        if( codefied != "" )
            codifieds.push_back( codefied );

    }

    return codifieds;

}

std::vector<Protein> proteins( const RNA rna ) {

    return proteins( split_in_codons( rna ) );

}



}  // namespace protein_translation
