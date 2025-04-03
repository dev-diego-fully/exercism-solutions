import java.util.Set;
import java.util.HashMap;
import java.util.Map;

class ItemCounter<T> {

    private final Map<T, Integer> counter = new HashMap<>();

    ItemCounter(Set<T> nucleotide) {
        nucleotide
                .stream()
                .forEach(this::initItem);
    }

    void countItem(T item) {
        this.counter.replace(item, this.counter.get(item) + 1);
    }

    Map<T, Integer> asMap() {
        return Map.copyOf(this.counter);
    }

    private void initItem(T item) {
        this.counter.put(item, 0);
    }

}
