import java.util.Map;

class NucleotideCounter {

    private final ItemCounter<Character> counter;

    NucleotideCounter(String sequence) {
        this.counter = new ItemCounter<>(DNAParser.NUCLEOTIDES);
        DNAParser
                .nucleotidesOf(sequence)
                .forEach(this.counter::countItem);
    }

    Map<Character, Integer> nucleotideCounts() {
        return this.counter.asMap();
    }

}