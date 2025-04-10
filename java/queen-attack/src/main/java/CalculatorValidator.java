public class CalculatorValidator {

    static void validateQueens(Queen queen1, Queen queen2) {
        ensureNonNullQueen(queen1);
        ensureNonNullQueen(queen2);
        ensureQueensInDistinctSquares(queen1, queen2);
    }

    static void ensureNonNullQueen(Queen queen) {
        if (queen == null) {
            throw new IllegalArgumentException(
                    "You must supply valid positions for both Queens.");
        }
    }

    private static void ensureQueensInDistinctSquares(Queen queen1, Queen queen2) {
        if (queen1.sharesSameSquare(queen2)) {
            throw new IllegalArgumentException(
                    "Queens cannot occupy the same position.");
        }
    }

}
