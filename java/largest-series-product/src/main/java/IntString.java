import java.util.stream.LongStream;

class IntString {

    static final String INVALID_INTSTRING_MSG = "String to search may only contain digits.";

    static void ensureIsIntString(String input) {
        if (!input.chars().allMatch(Character::isDigit)) {
            throw new IllegalArgumentException(INVALID_INTSTRING_MSG);
        }
    }

    static long product(String input) {
        return digits(input)
                .reduce((acc, v) -> acc * v)
                .getAsLong();
    }

    private static LongStream digits(String input) {
        return input
                .chars()
                .mapToLong(Character::getNumericValue);
    }

}
