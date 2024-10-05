import java.util.List;
import java.util.Set;
import java.util.HashSet;

class GottaSnatchEmAll {

    static Set<String> newCollection(List<String> cards) {
        return Set.copyOf(cards);
    }

    static boolean addCard(String card, Set<String> collection) {
        return collection.add(card);
    }

    static boolean canTrade(Set<String> myCollection, Set<String> theirCollection) {
        final boolean interestingToMe = !myCollection.containsAll(theirCollection);
        final boolean interestingForThem = !theirCollection.containsAll(myCollection);

        return interestingToMe && interestingForThem;
    }

    static Set<String> commonCards(List<Set<String>> collections) {
        HashSet<String> common = new HashSet<>();
        
        if(!collections.isEmpty()) {
            common.addAll(collections.get(0));
            collections.forEach(common::retainAll);

            return common;
        }

        return new HashSet<String>();
    }

    static Set<String> allCards(List<Set<String>> collections) {
        Set<String> union = new HashSet<String>();

        collections.forEach(union::addAll);
            
        return union;
    }
}
