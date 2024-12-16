import java.util.stream.IntStream;

public class EliudsEggs {

    public int eggCount(int number) {
        return (int) Integer
                .toBinaryString(number)
                .chars()
                .filter((digit) -> digit == '1')
                .count();
    }

}
