package react

// queue represents a generic, FIFO queue implemented as a doubly linked list.
type queue[T any] struct {
	first *node[T]
	last  *node[T]
}

// add inserts an element at the back of the queue.
func (l *queue[T]) add(v T) {
	if l.isEmpty() {
		l.insertInEmpty(v)
		return
	}
	l.last.next = newNode(v)
	l.last = l.last.next
}

// get removes and returns the element at the front of the queue.
// It returns a boolean indicating whether an element was found.
func (l *queue[T]) get() (T, bool) {
	if l.isEmpty() {
		var zero T
		return zero, false
	}
	if l.isSingle() {
		return l.removeFromSingle(), true
	}
	popped := l.first.value

	l.first = l.first.next

	return popped, true
}

// isEmpty returns true if the queue contains no elements.
func (l *queue[T]) isEmpty() bool {
	return l.first == nil
}

// isSingle returns true if the queue contains exactly one element.
func (l *queue[T]) isSingle() bool {
	return !l.isEmpty() && l.first == l.last
}

// insertInEmpty is a helper function to add the first element to an empty queue.
func (l *queue[T]) insertInEmpty(value T) {
	l.first = newNode(value)
	l.last = l.first
}

// removeFromSingle is a helper function to remove and return the only element from a queue.
func (l *queue[T]) removeFromSingle() T {
	value := l.last.value
	l.first = nil
	l.last = nil
	return value
}

// node is a single node in the linked list queue.
type node[T any] struct {
	value T
	next  *node[T]
}

// Next returns the next node in the queue.
func (n *node[T]) Next() *node[T] {
	return n.next
}

// newNode is a helper function to create a new node with the given value.
func newNode[T any](value T) *node[T] {
	return &node[T]{value: value, next: nil}
}
