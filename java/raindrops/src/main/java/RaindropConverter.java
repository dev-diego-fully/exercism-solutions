import java.util.List;
import java.util.Map;

class RaindropConverter {

    private final Map<Integer, String> raindropSounds = Map.ofEntries(
            Map.entry(3, "Pling"),
            Map.entry(5, "Plang"),
            Map.entry(7, "Plong"));

    public String convert(int number) {
        final List<String> sounds = this.soundsFor(number);

        if (sounds.isEmpty()) {
            return String.valueOf(number);
        }

        return String.join("", sounds);
    }

    private List<String> soundsFor(int number) {
        return raindropSounds
                .keySet()
                .stream()
                .filter((value) -> number % value == 0)
                .sorted()
                .map((value) -> raindropSounds.get(value))
                .toList();
    }

}
