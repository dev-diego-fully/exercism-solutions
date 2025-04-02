import java.lang.reflect.Array;
import java.util.NoSuchElementException;

class SimpleLinkedList<T> {

    Node<T> head = null;
    Node<T> tail = null;
    int count = 0;

    SimpleLinkedList() {
    }

    SimpleLinkedList(T[] values) {
        for (T value : values) {
            this.push(value);
        }
    }

    final void push(T value) {
        this.count++;
        if (this.tail == null) {
            this.tail = new Node(value);
            this.head = this.tail;
            return;
        }
        this.tail.next = new Node(value);
        this.tail = this.tail.next;
    }

    T pop() throws NoSuchElementException {
        if (this.tail == null) {
            throw new NoSuchElementException("");
        }

        T popped = this.tail.value;
        this.count--;

        if (this.head == this.tail) {
            this.head = null;
            this.tail = null;
            return popped;
        }

        Node<T> newTail = this.head;
        while (newTail.next != this.tail) {
            newTail = newTail.next;
        }
        newTail.next = null;
        this.tail = newTail;

        return popped;
    }

    void reverse() {
        if (this.head == null || this.head == this.tail) {
            return;
        }

        Node<T> next = null;
        Node<T> prev = null;

        for (Node<T> current = this.head; current != null; current = next) {
            next = current.next;
            current.next = prev;
            prev = current;
        }

        Node<T> aux = this.head;
        this.head = this.tail;
        this.tail = aux;
    }

    T[] asArray(Class<T> clazz) {
        T[] array = (T[]) Array.newInstance(clazz, this.count);

        int index = this.count - 1;
        for (Node<T> node = this.head; node != null; node = node.next) {
            array[index--] = node.value;
        }

        return array;
    }

    int size() {
        return this.count;
    }

    private static final class Node<T> {
        private T value;
        private Node<T> next = null;

        Node(T value) {
            this.value = value;
        }
    }

}
