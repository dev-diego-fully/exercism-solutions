import java.util.Stack;

class BracketChecker {

	private Stack<Bracket> stack;
	private Expression expression;
	private Boolean areMatchedAndNested;

	BracketChecker(String expression) {
		this.expression = new Expression(expression);
		this.stack = new Stack<Bracket>();
	}

	boolean areBracketsMatchedAndNestedCorrectly() {
		if (this.areMatchedAndNested == null) {
			this.areMatchedAndNested = this.processExpression();
		}
		return areMatchedAndNested;
	}

	boolean processExpression() {
		final boolean successfullyHandledBrackets = this.expression.getTokens().allMatch(this::handleBracket);
		return successfullyHandledBrackets && this.stack.isEmpty();
	}

	boolean handleBracket(Bracket bracket) {
		if (!bracket.isCloser()) {
			this.stack.push(bracket);
			return true;
		}
		if (this.stack.isEmpty()) {
			return false;
		}
		if (bracket.closes(this.stack.peek())) {
			this.stack.pop();
			return true;

		}
		return false;
	}

}