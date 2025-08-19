/// Translates an RNA sequence into a protein sequence.
///
/// This function simulates the biological process of translation. It reads the RNA sequence
/// in groups of three nucleotides (codons) and translates each codon into its corresponding
/// protein or a stop signal. The process continues until a stop codon is encountered or
/// the end of the RNA sequence is reached.
///
/// If any codon is invalid, the entire translation process is considered a failure.
///
/// # Arguments
///
/// * `rna` - A string slice containing the RNA sequence.
///
/// # Returns
///
/// An `Option` containing a `Vec` of string slices.
/// - `Some(Vec<&str>)` if the translation is successful, with the vector holding the protein names.
/// - `None` if the RNA sequence contains an invalid codon.
pub fn translate(rna: &str) -> Option<Vec<&str>> {
    let mut proteins = Vec::new();

    for codon in codons(rna) {
        match translate_codon(&codon) {
            TranlationResult::Protein(protein) => proteins.push(protein),
            TranlationResult::Stop => break,
            TranlationResult::Invalid => return None,
        }
    }

    Some(proteins)
}

/// An iterator that yields codons from an RNA sequence.
///
/// This helper function takes an RNA string and returns an iterator that steps through it
/// three characters at a time, generating each codon as a new `String`.
fn codons(rna: &str) -> impl Iterator<Item = String> {
    const CODON_LEN: usize = 3;
    (0..rna.len())
        .step_by(CODON_LEN)
        .map(|index| substring(rna, index, CODON_LEN))
}

/// Translates a single codon into its corresponding translation result.
///
/// This function uses a `match` expression to determine the result based on the codon string.
/// It can return a `Protein` variant with the name of the amino acid, a `Stop` signal,
/// or an `Invalid` result if the codon does not match any known pattern.
fn translate_codon(codon: &str) -> TranlationResult {
    match codon {
        "AUG" => TranlationResult::Protein("Methionine"),
        "UUU" | "UUC" => TranlationResult::Protein("Phenylalanine"),
        "UUA" | "UUG" => TranlationResult::Protein("Leucine"),
        "UCU" | "UCC" | "UCA" | "UCG" => TranlationResult::Protein("Serine"),
        "UAU" | "UAC" => TranlationResult::Protein("Tyrosine"),
        "UGU" | "UGC" => TranlationResult::Protein("Cysteine"),
        "UGG" => TranlationResult::Protein("Tryptophan"),
        "UAA" | "UAG" | "UGA" => TranlationResult::Stop,
        _ => TranlationResult::Invalid,
    }
}

/// An enumeration representing the possible outcomes of a codon translation.
///
/// - `Protein(&'static str)`: Indicates a successful translation to a named protein.
/// - `Stop`: Signifies a stop codon, which terminates the translation process.
/// - `Invalid`: Represents a malformed or unknown codon.
enum TranlationResult {
    Protein(&'static str),
    Stop,
    Invalid,
}

/// Extracts a substring from a string slice.
///
/// This helper function creates a new `String` by skipping a number of characters
/// and then taking a specific number of characters from the slice.
fn substring(string: &str, start: usize, size: usize) -> String {
    string.chars().skip(start).take(size).collect()
}