import java.util.LinkedList;
import java.util.List;
import java.util.stream.IntStream;

class GroupedDigitsNumber {

    public GroupedDigitsNumber(long number) {
        this.number = number;
        this.groupedDigits = this.getDigitsGrouped();
    }

    public List<DigitsGroup> getGroupedDigits() {
        return this.groupedDigits;
    }

    private List<DigitsGroup> getDigitsGrouped() {
        final List<Integer> digits = this.getPaddedDigits();
        final int groupsNumber = digits.size() / GROUP_DIGITS_SIZE;

        return IntStream
                .range(0, groupsNumber)
                .mapToObj((group) -> new DigitsGroup(
                        digits.subList(
                                group * GROUP_DIGITS_SIZE,
                                (group + 1) * GROUP_DIGITS_SIZE),
                        group,
                        groupsNumber))
                .toList();
    }

    private List<Integer> getDigits() {
        return String
                .valueOf(this.number)
                .chars()
                .mapToObj((digit) -> digit - '0')
                .toList();
    }

    private List<Integer> getPaddedDigits() {
        final List<Integer> digits = new LinkedList<Integer>(this.getDigits());

        if (digits.size() % GROUP_DIGITS_SIZE != 0) {
            IntStream
                    .range(0, GROUP_DIGITS_SIZE - digits.size() % GROUP_DIGITS_SIZE)
                    .forEach((i) -> digits.add(0, 0));
        }

        return digits;
    }

    private final long number;
    private final List<DigitsGroup> groupedDigits;

    private static final int GROUP_DIGITS_SIZE = 3;

}
