class Leap {

    private boolean isDivisible(int number, int divisor) {
        return number % divisor == 0;
    }

    boolean isLeapYear(int year) {
        return isDivisible(year, 4) && (!isDivisible(year, 100) || isDivisible(year, 400));
    }

}
