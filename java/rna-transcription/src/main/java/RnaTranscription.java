import java.util.Map;
import java.util.stream.IntStream;
import java.lang.StringBuilder;

class RnaTranscription {

    public String transcribe(String dnaStrand) {
        return dnaStrand
                .chars()
                .mapToObj((nucleotide) -> this.translateNucleotide((char) nucleotide))
                .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
                .toString();
    }

    private char translateNucleotide(char nucleotide) {
        final Character translated = nucleotideMap.get(nucleotide);
        if (translated == null) {
            throw new IllegalArgumentException("Invalid nucleotide found: " + translated);
        }
        return translated;
    }

    private static final Map<Character, Character> nucleotideMap = Map.of(
            'C', 'G',
            'G', 'C',
            'T', 'A',
            'A', 'U');

}
