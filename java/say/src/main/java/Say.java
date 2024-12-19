import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Say {

    public String say(long number) {
        if (number < MIN_VALUE || number >= MAX_VALUE) {
            throw new IllegalArgumentException(
                    "The number is outside the accepted range of [0, 1e12).");
        }

        return this.say(new GroupedDigitsNumber(number));
    }

    private String say(GroupedDigitsNumber number) {
        return number
                .getGroupedDigits()
                .stream()
                .filter((group) -> !group.isSilenced())
                .map(this::say)
                .collect(Collectors.joining(" "));
    }

    private String say(DigitsGroup group) {
        final String spelled = this.spellsFromDigits(
                group.getHundred(), group.getTen(), group.getUnit());

        if (group.usesPrefixes()) {
            return spelled + " " + this.getPrefix(group.getGroupNumber());
        }
        return spelled;
    }

    private String getPrefix(int groupNumber) {
        return PREFIXES.get(groupNumber - 1);
    }

    private String spellsFromDigits(int units) {
        return SPECIAL_NUMBERS.get(units);
    }

    private String spellsFromDigits(int tens, int units) {
        if (tens == 0) {
            return this.spellsFromDigits(units);
        }
        if (tens == 1) {
            return SPECIAL_NUMBERS.get(tens * 10 + units);
        }

        final String spelledTens = SPECIAL_NUMBERS.get(tens * 10);

        if (units != 0) {
            return spelledTens + "-" + SPECIAL_NUMBERS.get(units);
        }

        return spelledTens;
    }

    private String spellsFromDigits(int hundred, int tens, int units) {
        if (hundred == 0) {
            return this.spellsFromDigits(tens, units);
        }
        final String spelledHundred = SPECIAL_NUMBERS.get(hundred) + " hundred";
        if (tens == 0 && units == 0) {
            return spelledHundred;
        }
        return spelledHundred + " " + this.spellsFromDigits(tens, units);
    }

    private static final int MIN_VALUE = 0;
    private static final long MAX_VALUE = (long) 1e12;

    private static final List<String> PREFIXES = List.of(
            "thousand", "million", "billion");

    private static final Map<Integer, String> SPECIAL_NUMBERS = Map.ofEntries(
            Map.entry(0, "zero"),
            Map.entry(1, "one"),
            Map.entry(2, "two"),
            Map.entry(3, "three"),
            Map.entry(4, "four"),
            Map.entry(5, "five"),
            Map.entry(6, "six"),
            Map.entry(7, "seven"),
            Map.entry(8, "eight"),
            Map.entry(9, "nine"),
            Map.entry(10, "ten"),
            Map.entry(11, "eleven"),
            Map.entry(12, "twelve"),
            Map.entry(13, "thirteen"),
            Map.entry(14, "fourteen"),
            Map.entry(15, "fifteen"),
            Map.entry(16, "sixteen"),
            Map.entry(17, "seventeen"),
            Map.entry(18, "eighteen"),
            Map.entry(19, "nineteen"),
            Map.entry(20, "twenty"),
            Map.entry(30, "thirty"),
            Map.entry(40, "forty"),
            Map.entry(50, "fifty"),
            Map.entry(60, "sixty"),
            Map.entry(70, "seventy"),
            Map.entry(80, "eighty"),
            Map.entry(90, "ninety"));

}
