import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

class Flattener {

    List<Object> flatten(Collection<Object> list) {
        return do_flatten(list)
                .toList();
    }
    
    private Stream<Object> do_flatten(Object list) {
        if (list instanceof Collection<?>) {
            return ((Collection<?>) list)
                    .stream()
                    .flatMap(this::do_flatten)
                    .filter(Objects::nonNull);
        }

        return Stream.of(list);
    }

}