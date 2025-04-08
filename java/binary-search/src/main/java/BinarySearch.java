import java.util.List;

class BinarySearch {

    private List<Integer> items;

    BinarySearch(List<Integer> items) {
        this.items = items;
    }

    int indexOf(int item) throws ValueNotFoundException {
        final int itemIndex = this.find(item, 0, this.items.size() - 1);

        if (itemIndex == -1) {
            throw new ValueNotFoundException("Value not in array");
        }

        return itemIndex;
    }

    private int find(int item, int bot, int top) {
        if (bot > top) {
            return -1;
        }

        final int middle = (bot + top) / 2;
        final int itemInMiddle = this.items.get(middle);

        if (itemInMiddle < item) {
            return this.find(item, middle + 1, top);
        }
        if (itemInMiddle > item) {
            return this.find(item, bot, middle - 1);

        }
        return middle;
    }

}
