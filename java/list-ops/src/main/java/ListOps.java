import java.util.LinkedList;
import java.util.List;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Stream;

class ListOps {

    static <T> List<T> append(List<T> list1, List<T> list2) {
        return Stream
                .concat(list1.stream(), list2.stream())
                .toList();
    }

    static <T> List<T> concat(List<List<T>> listOfLists) {
        if (listOfLists.isEmpty()) {
            return List.of();
        }
        return listOfLists.stream()
                .map(List::stream)
                .reduce(Stream::concat)
                .get()
                .toList();
    }

    static <T> List<T> filter(List<T> list, Predicate<T> predicate) {
        final LinkedList<T> filtereds = new LinkedList<>();

        list.forEach(e -> {
            if (predicate.test(e)) {
                filtereds.addLast(e);
            }
        });

        return filtereds.stream()
                .toList();
    }

    static <T> int size(List<T> list) {
        return list.size();
    }

    static <T, U> List<U> map(List<T> list, Function<T, U> transform) {
        LinkedList<U> mapped = new LinkedList<>();

        list.forEach(e -> mapped.addLast(transform.apply(e)));

        return mapped.stream()
                .toList();
    }

    static <T> List<T> reverse(List<T> list) {
        LinkedList<T> reversed = new LinkedList<>();

        list.forEach(e -> reversed.addFirst(e));

        return reversed.stream()
                .toList();
    }

    static <T, U> U foldLeft(List<T> list, U initial, BiFunction<U, T, U> f) {
        U result = initial;

        for (T element : list) {
            result = f.apply(result, element);
        }

        return result;
    }

    static <T, U> U foldRight(List<T> list, U initial, BiFunction<T, U, U> f) {
        U result = initial;

        for (int i = list.size() - 1; i >= 0; i--) {
            result = f.apply(list.get(i), result);
        }

        return result;
    }

    private ListOps() {
        // No instances.
    }

}
