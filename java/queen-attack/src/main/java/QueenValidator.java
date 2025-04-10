public class QueenValidator {

    private static final int BOARD_SIZE = 8;

    static void validateQueen(Queen queen) {
        ensurePositiveColumn(queen);
        ensurePositiveRow(queen);

        ensureColumnIsInBoard(queen);
        ensureRowIsInBoard(queen);
    }

    private static void ensurePositiveRow(Queen queen) {
        if (queen.getRow() < 0) {
            throw new IllegalArgumentException(
                    "Queen position must have positive row.");
        }
    }

    private static void ensurePositiveColumn(Queen queen) {
        if (queen.getColumn() < 0)
            throw new IllegalArgumentException(
                    "Queen position must have positive column.");
    }

    private static void ensureColumnIsInBoard(Queen queen) {
        if (queen.getColumn() >= BOARD_SIZE) {
            throw new IllegalArgumentException(
                    "Queen position must have column <= " + (BOARD_SIZE - 1) + ".");
        }
    }

    private static void ensureRowIsInBoard(Queen queen) {
        if (queen.getRow() >= BOARD_SIZE) {
            throw new IllegalArgumentException(
                    "Queen position must have row <= " + (BOARD_SIZE - 1) + ".");
        }
    }

}
