import java.util.Collection;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Stream;

class CustomSet<T> {

    private final Map<T, Boolean> elements;

    CustomSet() {
        this.elements = new HashMap<>();
    }

    CustomSet(Collection<T> data) {
        this.elements = new HashMap<>();
        data.forEach(this::add);
    }

    private CustomSet(Stream<T> data) {
        this.elements = new HashMap<>();
        data.forEach(this::add);
    }

    boolean isEmpty() {
        return this.elements.isEmpty();
    }

    boolean contains(T element) {
        return this.elements.getOrDefault(element, false);
    }

    boolean isDisjoint(CustomSet<T> other) {
        return this.elements
                .keySet()
                .stream()
                .filter(other::contains)
                .findFirst()
                .isEmpty();
    }

    boolean add(T element) {
        if (this.contains(element)) {
            return false;
        }
        this.elements.put(element, true);
        return true;
    }

    @Override
    public boolean equals(Object obj) {
        return false;
    }

    public boolean equals(CustomSet<T> other) {
        return this.isSubset(other) && other.isSubset(this);
    }

    CustomSet<T> getIntersection(CustomSet<T> other) {
        final Stream<T> repeatedElements = this.elements
                .keySet()
                .stream()
                .filter(other::contains);

        return new CustomSet<T>(repeatedElements);
    }

    CustomSet<T> getUnion(CustomSet<T> other) {
        final Stream<T> allElements = Stream.concat(
                this.elements.keySet().stream(),
                other.elements.keySet().stream());

        return new CustomSet<T>(allElements);
    }

    CustomSet<T> getDifference(CustomSet<T> other) {
        final Stream<T> exclusiveElements = this.elements
                .keySet()
                .stream()
                .filter(e -> !other.contains(e));

        return new CustomSet<>(exclusiveElements);
    }

    boolean isSubset(CustomSet<T> other) {
        return other.elements
                .keySet()
                .stream()
                .allMatch(this::contains);
    }
}
