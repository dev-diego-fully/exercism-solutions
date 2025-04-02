class DoublyLinkedList<T> {
    private Element<T> head;
    private Element<T> tail;

    void push(T value) {
        if(this.tail == null) {
            this.tail = new Element<T>(value, this.tail, null);
            this.head = this.tail;
            return;
        }
        this.tail.next = new Element<T>(value, this.tail, null);
        this.tail = this.tail.next;
    }

    T pop() throws IllegalArgumentException {
        if(this.tail == null) {
            throw new IllegalArgumentException("");
        }
        T popped = this.tail.value;
        
        if(this.tail == this.head) {
            this.tail = null;
            this.head = null;
            return popped;
        }
        
        this.tail = this.tail.prev;
        this.tail.next = null;
        return popped;
    }

    void unshift(T value) {
        if(this.head == null) {
            this.head = new Element<T>(value, null, this.head);
            this.tail = this.head;
            return;
        }
        this.head.prev = new Element<T>(value, null, this.head);
        this.head = this.head.prev;
    }

    T shift() throws IllegalArgumentException {
        if(this.head == null) {
            throw new IllegalArgumentException("");
        }
        
        T shifted = this.head.value;
        
        if(this.head == this.tail) {
            this.tail = null;
            this.head = null;
            return shifted;
        }
        
        this.head = this.head.next;
        this.head.prev = null;
        return shifted;
    }

    private static final class Element<T> {
        private final T value;
        private Element<T> prev;
        private Element<T> next;

        Element(T value, Element<T> prev, Element<T> next) {
            this.value = value;
            this.prev = prev;
            this.next = next;
        }
    }
}
