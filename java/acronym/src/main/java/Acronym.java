import java.util.stream.Stream;

class Acronym {

    public Acronym(String phrase) {
        this.phrase = phrase;
        this.acronym = this.processAcronym();
    }

    public String get() {
        return this.acronym;
    }

    private String processAcronym() {
        final String[] words = this.phrase
                .replaceAll(IGNORABLE_CHARACTERS_PATTERN, " ")
                .split("\s+");

        return Stream
                .of(words)
                .map((word) -> String.valueOf(word.charAt(0)).toUpperCase())
                .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
                .toString();
    }

    private final String phrase;
    private final String acronym;
    private static final String IGNORABLE_CHARACTERS_PATTERN = "[^\s\'a-zA-Z0-9]";

}
