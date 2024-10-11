import java.util.stream.IntStream;

class ArmstrongNumbers {

    private int armstrongValue(int digit, int length) {
        return (int) Math.pow(digit, length);
    }

    private int[] digits(int integer) {
        return Integer
                .toString(integer)
                .chars()
                .map(Character::getNumericValue)
                .toArray();
    }

    boolean isArmstrongNumber(int numberToCheck) {
        int[] digits = this.digits(numberToCheck);
        int armstrongSum = 0;
        for (int digit : digits) {
            armstrongSum += armstrongValue(digit, digits.length);
        }
        return armstrongSum == numberToCheck;
    }

}
