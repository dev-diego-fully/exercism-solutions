import java.util.Map;

class NucleotideCounter {

    private final Map<Character, Integer> counter;

    NucleotideCounter(String sequence) {
        ItemCounter<Character> counter = new ItemCounter<>(DNAParser.NUCLEOTIDES);
        DNAParser
                .nucleotidesOf(sequence)
                .forEach(counter::countItem);
        this.counter = counter.asMap();
    }

    Map<Character, Integer> nucleotideCounts() {
        return this.counter;
    }

}