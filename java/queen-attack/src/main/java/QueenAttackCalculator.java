import java.util.stream.Stream;

class QueenAttackCalculator {

    private final Queen queen1;
    private final Queen queen2;

    QueenAttackCalculator(Queen queen1, Queen queen2) {
        this.queen1 = queen1;
        this.queen2 = queen2;

        CalculatorValidator.validateQueens(queen1, queen2);
    }

    boolean canQueensAttackOneAnother() {
        return Stream
                .of(
                        this.queen1.sharesRow(queen2),
                        this.queen1.sharesColumn(queen2),
                        this.queen1.sharesDiagonal(queen2))
                .anyMatch(can -> can);
    }
}