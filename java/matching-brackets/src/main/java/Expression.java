import java.util.Optional;
import java.util.stream.Stream;

public class Expression {

	private String expression;

	Expression(String expression) {
		this.expression = expression;
	}

	Stream<Bracket> getTokens() {
		return this.expression.chars()
			.mapToObj((code) -> (char) code)
			.map(Bracket::fromChar)
			.filter(Optional::isPresent)
			.map(Optional::get);
	}

}
