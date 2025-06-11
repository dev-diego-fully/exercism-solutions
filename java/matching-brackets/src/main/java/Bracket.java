import java.util.Optional;

public enum Bracket {

	OPEN_BRACKET, CLOSE_BRACKET, OPEN_PARENTHESES, CLOSE_PARENTHESES, OPEN_BRACE, CLOSE_BRACE;

	public static Optional<Bracket> fromChar(char character) {
		return switch (character) {
		case '{' -> Optional.of(OPEN_BRACE);
		case '}' -> Optional.of(CLOSE_BRACE);
		case '(' -> Optional.of(OPEN_PARENTHESES);
		case ')' -> Optional.of(CLOSE_PARENTHESES);
		case '[' -> Optional.of(OPEN_BRACKET);
		case ']' -> Optional.of(CLOSE_BRACKET);
		default -> Optional.empty();
		};
	}

	public boolean isCloser() {
		return switch (this) {
		case CLOSE_BRACKET, CLOSE_PARENTHESES, CLOSE_BRACE -> true;
		default -> false;
		};
	}

	public boolean closes(Bracket other) {
		return switch (this) {
		case CLOSE_BRACKET -> other == OPEN_BRACKET;
		case CLOSE_PARENTHESES -> other == OPEN_PARENTHESES;
		case CLOSE_BRACE -> other == OPEN_BRACE;
		default -> false;
		};
	}

}
