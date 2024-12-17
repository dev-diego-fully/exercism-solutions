package main.java;

import java.util.Map;

import javax.swing.tree.TreeNode;

public enum TranslationResult {

    METHIONINE,
    PHENYLALANINE,
    LEUCINE,
    SERINE,
    TYROSINE,
    CYSTEINE,
    TRYPTOPHAN,
    STOP,
    INVALID;

    public static TranslationResult fromCodon(String codon) {
        final TranslationResult result = CODON_TRANSLATION_MAP.get(codon);

        if (result == null) {
            return TranslationResult.INVALID;
        }

        return result;
    }

    public String getProteinName() {
        final String name = PROTEIN_NAMES.get(this);

        if (name == null) {
            throw new IllegalArgumentException("Invalid codon");
        }

        return name;
    }

    private static final Map<TranslationResult, String> PROTEIN_NAMES = Map.ofEntries(
            Map.entry(TranslationResult.METHIONINE, "Methionine"),
            Map.entry(TranslationResult.PHENYLALANINE, "Phenylalanine"),
            Map.entry(TranslationResult.LEUCINE, "Leucine"),
            Map.entry(TranslationResult.SERINE, "Serine"),
            Map.entry(TranslationResult.TYROSINE, "Tyrosine"),
            Map.entry(TranslationResult.CYSTEINE, "Cysteine"),
            Map.entry(TranslationResult.TRYPTOPHAN, "Tryptophan"));

    private static final Map<String, TranslationResult> CODON_TRANSLATION_MAP = Map.ofEntries(
            Map.entry("AUG", TranslationResult.METHIONINE),
            Map.entry("UUU", TranslationResult.PHENYLALANINE),
            Map.entry("UUC", TranslationResult.PHENYLALANINE),
            Map.entry("UUA", TranslationResult.LEUCINE),
            Map.entry("UUG", TranslationResult.LEUCINE),
            Map.entry("UCU", TranslationResult.SERINE),
            Map.entry("UCC", TranslationResult.SERINE),
            Map.entry("UCA", TranslationResult.SERINE),
            Map.entry("UCG", TranslationResult.SERINE),
            Map.entry("UAU", TranslationResult.TYROSINE),
            Map.entry("UAC", TranslationResult.TYROSINE),
            Map.entry("UGU", TranslationResult.CYSTEINE),
            Map.entry("UGC", TranslationResult.CYSTEINE),
            Map.entry("UGG", TranslationResult.TRYPTOPHAN),
            Map.entry("UAA", TranslationResult.STOP),
            Map.entry("UAG", TranslationResult.STOP),
            Map.entry("UGA", TranslationResult.STOP));

}