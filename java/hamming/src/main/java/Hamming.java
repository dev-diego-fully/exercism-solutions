import java.util.stream.IntStream;

public class Hamming {

    private final int hamming;

    public Hamming(String leftStrand, String rightStrand) {
        this.hamming = this.computeHammingDistance(leftStrand, rightStrand);
    }

    public int getHammingDistance() {
        return this.hamming;
    }

    private int computeHammingDistance(String leftStrand, String rightStrand) {
        if (leftStrand.length() != rightStrand.length()) {
            throw new IllegalArgumentException("strands must be of equal length");
        }

        return (int) IntStream
                .range(0, leftStrand.length())
                .filter((index) -> leftStrand.charAt(index) != rightStrand.charAt(index))
                .count();
    }
}
