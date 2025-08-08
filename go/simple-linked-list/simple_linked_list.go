// Package linkedlist provides a singly linked list implementation.
package linkedlist

import "errors"

// List represents a singly linked list with a head and tail pointer.
type List struct {
	head   *node
	tail   *node
	length int
}

// New creates a new list from a slice of integers.
func New(elements []int) *List {
	list := List{}

	for _, element := range elements {
		list.Push(element)
	}

	return &list
}

// Size returns the number of elements in the list.
func (l *List) Size() int {
	return l.length
}

// Push adds a new element to the end of the list.
func (l *List) Push(element int) {
	node := newNode(element)
	l.length++

	if l.tail == nil {
		l.head = node
		l.tail = node
	} else {
		l.tail.next = node
		l.tail = l.tail.next
	}
}

// Pop removes and returns the last element from the list.
// It returns an error if the list is empty.
func (l *List) Pop() (int, error) {
	if l.head == nil {
		return 0, errors.New("can't pop from empty list")
	}
	popped := l.tail.element
	l.length--

	if l.tail == l.head {
		l.head = nil
		l.tail = nil
		return popped, nil
	}

	l.tail = l.preTail()
	l.tail.next = nil

	return popped, nil
}

// Array returns the elements of the list as a slice of integers.
func (l *List) Array() []int {
	array := make([]int, 0, l.Size())

	for current := l.head; current != nil; current = current.next {
		array = append(array, current.element)
	}

	return array
}

// Reverse reverses the list in place and returns the modified list.
func (l *List) Reverse() *List {
	if l.head == nil || l.head == l.tail {
		return l
	}
	var next, prev *node = nil, nil

	for current := l.head; current != nil; prev, current = current, next {
		next = current.next
		current.next = prev
	}

	l.head, l.tail = l.tail, l.head

	return l
}

// preTail is a private helper method that finds and returns the node before the tail.
func (l *List) preTail() *node {
	var pre *node

	for pre = l.head; pre.next != l.tail; pre = pre.next {

	}

	return pre
}

// node represents a single node in the linked list.
type node struct {
	next    *node
	element int
}

// newNode is a private helper function to create a new node.
func newNode(element int) *node {
	return &node{element: element, next: nil}
}
