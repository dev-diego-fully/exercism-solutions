import java.math.BigInteger;

class Grains {

    private static final int FIRST_SQUARE = 1;
    private static final int LAST_SQUARE = 64;

    BigInteger grainsOnSquare(final int square) {
        if (square < FIRST_SQUARE || square > LAST_SQUARE) {
            throw new IllegalArgumentException(
                    "square must be between " + FIRST_SQUARE + " and " + LAST_SQUARE);
        }
        return BigInteger.TWO
                .pow(square - 1);
    }

    BigInteger grainsOnBoard() {
        return BigInteger.TWO
                .pow(LAST_SQUARE)
                .subtract(BigInteger.ONE);
    }

}
