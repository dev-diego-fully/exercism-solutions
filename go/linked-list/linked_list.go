// Package linkedlist provides an implementation of a doubly linked list.
// The list can store elements of any type using the empty interface.
package linkedlist

import "errors"

// List represents a doubly linked list.
type List struct {
	first *Node
	last  *Node
}

// NewList creates and returns a new List initialized with the provided elements.
// The elements are added to the end of the list in the order they are given.
func NewList(elements ...interface{}) *List {
	list := List{}

	for _, element := range elements {
		list.Push(element)
	}

	return &list
}

// First returns a pointer to the first Node of the list.
// It returns nil if the list is empty.
func (l *List) First() *Node {
	return l.first
}

// Last returns a pointer to the last Node of the list.
// It returns nil if the list is empty.
func (l *List) Last() *Node {
	return l.last
}

// Unshift adds a new element to the beginning of the list.
func (l *List) Unshift(v interface{}) {
	if l.isEmpty() {
		l.insertInEmpty(v)
		return
	}
	l.first.prev = newNode(v, nil, l.first)
	l.first = l.first.prev
}

// Push adds a new element to the end of the list.
func (l *List) Push(v interface{}) {
	if l.isEmpty() {
		l.insertInEmpty(v)
		return
	}
	l.last.next = newNode(v, l.last, nil)
	l.last = l.last.next
}

// Shift removes and returns the first element of the list.
// It returns an error if the list is empty.
func (l *List) Shift() (interface{}, error) {
	if l.isEmpty() {
		return nil, errors.New("can't shift from a empty list")
	}
	if l.isSingle() {
		return l.removeFromSingle(), nil
	}
	popped := l.first.Value

	l.first = l.first.next
	l.first.prev = nil

	return popped, nil
}

// Pop removes and returns the last element of the list.
// It returns an error if the list is empty.
func (l *List) Pop() (interface{}, error) {
	if l.isEmpty() {
		return nil, errors.New("can't pop from a empty list")
	}
	if l.isSingle() {
		return l.removeFromSingle(), nil
	}
	popped := l.last.Value

	l.last = l.last.prev
	l.last.next = nil

	return popped, nil
}

// Reverse reverses the order of the elements in the list in place.
func (l *List) Reverse() {
	var next *Node = nil

	for current := l.first; current != nil; current = next {
		next = current.next
		current.prev, current.next = current.next, current.prev
	}

	l.first, l.last = l.last, l.first
}

// isEmpty checks if the list is empty.
func (l *List) isEmpty() bool {
	return l.first == nil
}

// isSingle checks if the list contains only one node.
func (l *List) isSingle() bool {
	return !l.isEmpty() && l.first == l.last
}

// insertInEmpty is a helper method for adding the first node to an empty list.
func (l *List) insertInEmpty(value interface{}) {
	l.first = newNode(value, nil, nil)
	l.last = l.first
}

// removeFromSingle is a helper method for removing the only node from a list.
func (l *List) removeFromSingle() interface{} {
	value := l.last.Value
	l.first = nil
	l.last = nil
	return value
}

// Node represents a node in the doubly linked list.
type Node struct {
	Value interface{}
	prev  *Node
	next  *Node
}

// Next returns the next Node in the list.
func (n *Node) Next() *Node {
	return n.next
}

// Prev returns the previous Node in the list.
func (n *Node) Prev() *Node {
	return n.prev
}

// newNode is a helper function to create a new Node with the given value and links.
func newNode(value interface{}, prev, next *Node) *Node {
	return &Node{Value: value, prev: prev, next: next}
}
