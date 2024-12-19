import java.util.List;
import java.util.stream.Collectors;

class MicroBlog {

    final static int CHARS_LIMIT = 5;

    public String truncate(String input) {
        return input
                .codePoints()
                .mapToObj(Character::toChars)
                .limit(CHARS_LIMIT)
                .map(String::valueOf)
                .collect(Collectors.joining());
    }
}
