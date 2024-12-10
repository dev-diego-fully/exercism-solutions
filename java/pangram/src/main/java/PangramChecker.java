import java.util.stream.IntStream;

public class PangramChecker {

    private static final String alphabet = "abcdefghijklmnopqrstuvwxyz";

    public boolean isPangram(String input) {
        final String lowered = input.toLowerCase();

        return alphabet
                .chars()
                .allMatch((letter) -> this.hasChar(lowered, letter));
    }

    private boolean hasChar(String tested, int chr) {
        final int notFound = -1;
        return tested.indexOf(chr) != notFound;
    }

}
