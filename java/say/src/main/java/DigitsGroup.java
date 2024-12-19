import java.util.List;

public class DigitsGroup {

    public DigitsGroup(List<Integer> digits, int groupPosition, int groupsCount) {
        this.digits = digits.subList(0, GROUP_SIZE);
        this.groupNumber = groupsCount - groupPosition - 1;
        this.silencedIfZero = this.groupNumber > 0 || groupsCount > 1;
    }

    public int getGroupNumber() {
        return this.groupNumber;
    }

    public int getUnit() {
        return this.digits.get(2);
    }

    public int getTen() {
        return this.digits.get(1);
    }

    public int getHundred() {
        return this.digits.get(0);
    }

    public boolean isSilenced() {
        return this.silencedIfZero && this.isZero();
    }

    public boolean usesPrefixes() {
        return this.groupNumber > 0;
    }

    private boolean isZero() {
        return this.digits
                .stream()
                .allMatch(Integer.valueOf(0)::equals);
    }

    private final List<Integer> digits;
    private final int groupNumber;
    private final boolean silencedIfZero;

    private static final int GROUP_SIZE = 3;

}
