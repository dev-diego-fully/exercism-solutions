class DifferenceOfSquaresCalculator {

    int computeSquareOfSumTo(int input) {
        final int sumToInput = (1 + input) * input / 2;
        return sumToInput * sumToInput;
    }

    int computeSumOfSquaresTo(int input) {
        return input * (input + 1) * (2 * input + 1) / 6;
    }

    int computeDifferenceOfSquares(int input) {
        return computeSquareOfSumTo(input) - computeSumOfSquaresTo(input);
    }

}
