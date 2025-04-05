class IntegerUtils {

    static int pow(int base, int pow) {
        return (int) Math.pow((double) base, (double) pow);
    }

    static int mdc(int a, int b) {
        if (b == 0) {
            return a;
        }
        return mdc(b, a % b);
    }

}
