import java.util.stream.IntStream;

public class PangramChecker {

    private static final String notLetterPattern = "[^a-zA-Z]";
    private static final int alphabetSize = 26;

    public boolean isPangram(String input) {
        return input
                .replaceAll(notLetterPattern, "")
                .toLowerCase()
                .chars()
                .distinct()
                .count() == alphabetSize;
    }

}
