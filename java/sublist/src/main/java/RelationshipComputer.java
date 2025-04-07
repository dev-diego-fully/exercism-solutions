import java.util.List;
import java.util.stream.IntStream;

class RelationshipComputer<T> {

    Relationship computeRelationship(List<T> firstList, List<T> secondList) {
        final boolean firstSubOfSecond = this.isSublist(firstList, secondList);
        final boolean secondSubOfFirst = this.isSublist(secondList, firstList);

        if (firstSubOfSecond == secondSubOfFirst) {
            return firstSubOfSecond ? Relationship.EQUAL : Relationship.UNEQUAL;
        }

        return firstSubOfSecond ? Relationship.SUBLIST : Relationship.SUPERLIST;
    }

    private boolean isSublist(List<T> first, List<T> second) {
        if (first.size() > second.size()) {
            return false;
        }
        final int sliceLen = first.size();

        return IntStream
                .rangeClosed(0, second.size() - sliceLen)
                .anyMatch((s) -> second.subList(s, s + sliceLen).equals(first));
    }

}
