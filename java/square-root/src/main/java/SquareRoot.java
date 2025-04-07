public class SquareRoot {
    public int squareRoot(int radicand) {
        return this.findSquareRoot(radicand, 1, radicand);
    }

    private int findSquareRoot(int radicand, int bot, int top) {
        final int middle = (bot + top) / 2;
        final int square = middle * middle;

        if (square == radicand) {
            return middle;
        }
        if (square > radicand) {
            return findSquareRoot(radicand, bot, middle);
        }
        return findSquareRoot(radicand, middle, top);
    }

}
