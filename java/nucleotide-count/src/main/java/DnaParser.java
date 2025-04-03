import java.util.stream.Stream;
import java.util.Set;

class DNAParser {

    public static final Set<Character> NUCLEOTIDES = Set.of('A', 'T', 'C', 'G');

    static Stream<Character> nucleotidesOf(String sequence) throws IllegalArgumentException {
        if (!DNAParser.isDna(sequence)) {
            throw new IllegalArgumentException("Not a valid dna sequence");
        }
        return sequence
                .chars()
                .mapToObj(v -> (char) v);
    }

    private static boolean isDna(String sequence) {
        return sequence
                .chars()
                .mapToObj(v -> (char) v)
                .allMatch(DNAParser::isNucleotide);
    }

    private static boolean isNucleotide(char candidate) {
        return DNAParser.NUCLEOTIDES.contains(candidate);
    }

}
