import java.util.List;
import java.util.stream.Collectors;

class Anagram {

    public Anagram(String word) {
        this.cleaned = this.clean(word);
        this.normalized = this.normalize(this.cleaned);
    }

    public List<String> match(List<String> candidates) {
        return candidates.stream().filter(this::isAnagram).toList();
    }

    private String cleaned;
    private String normalized;

    private boolean isAnagram(String word) {
        final String cleaned = this.clean(word);

        if (this.cleaned.equals(cleaned)) {
            return false;
        }

        return this.normalized.equals(this.normalize(cleaned));
    }

    private String normalize(String cleaned) {
        return cleaned
                .codePoints()
                .sorted()
                .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
                .toString();
    }

    private String clean(String word) {
        return word
                .codePoints()
                .filter(Character::isAlphabetic)
                .map(Character::toLowerCase)
                .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
                .toString();
    }

}