class CollatzCalculator {

    int computeStepCount(int start) {
        if(start <= 0) {
            throw new IllegalArgumentException("Only positive integers are allowed");
        }
        int steps = 0;
        for(int current = start; current != 1; current = nextNumber(current)) {
            steps++;
        }
        return steps;
    }

    int nextNumber(int value) {
        return value % 2 == 0 ? value/2 : 3 * value + 1;
    }

}
