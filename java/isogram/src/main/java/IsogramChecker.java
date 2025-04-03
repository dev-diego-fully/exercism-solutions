import java.util.stream.IntStream;

class IsogramChecker {

    boolean isIsogram(String phrase) {
        final long totalLetters = lettersOf(phrase).count();
        final long uniqueLetters = lettersOf(phrase).distinct().count();

        return totalLetters == uniqueLetters;
    }

    IntStream lettersOf(String phrase) {
        return phrase
                .chars()
                .filter(Character::isAlphabetic)
                .map(Character::toLowerCase);
    }

}
