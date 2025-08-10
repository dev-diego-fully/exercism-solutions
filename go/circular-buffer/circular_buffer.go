// Package circular provides a circular buffer implementation.
package circular

import (
	"errors"
)

// Buffer is a circular buffer that stores a fixed number of bytes.
// It overwrites the oldest element when the buffer is full.
type Buffer struct {
	count    int
	tail     int
	head     int
	elements []byte
}

// NewBuffer creates a new circular buffer with a specified size.
func NewBuffer(size int) *Buffer {
	return &Buffer{
		elements: make([]byte, size),
		count:    0,
		head:     0,
		tail:     0,
	}
}

// ReadByte reads a byte from the buffer's head.
// It returns an error if the buffer is empty.
func (b *Buffer) ReadByte() (byte, error) {
	if b.isEmpty() {
		return 0, errors.New("can't read from empty buffer")
	}

	value := b.elements[b.head]

	b.advanceHead()
	b.count--

	return value, nil
}

// WriteByte writes a byte to the buffer's tail.
// It returns an error if the buffer is full.
func (b *Buffer) WriteByte(c byte) error {
	if b.isFull() {
		return errors.New("can't write in a full buffer")
	}
	b.elements[b.tail] = c

	b.advanceTail()
	b.count++

	return nil
}

// Overwrite writes a byte to the buffer's tail, overwriting the oldest element if the buffer is full.
func (b *Buffer) Overwrite(c byte) {
	b.elements[b.tail] = c
	b.advanceTail()

	if !b.isFull() {
		b.count++
	} else {
		b.advanceHead()
	}
}

// Reset clears the buffer, making it empty.
func (b *Buffer) Reset() {
	b.count = 0
	b.head = 0
	b.tail = 0
}

// isEmpty checks if the buffer is empty.
func (b *Buffer) isEmpty() bool {
	return b.count <= 0
}

// isFull checks if the buffer is full.
func (b *Buffer) isFull() bool {
	return b.count >= len(b.elements)
}

// advanceTail moves the tail pointer to the next position in the circular buffer.
func (b *Buffer) advanceTail() {
	b.tail = (b.tail + 1) % len(b.elements)
}

// advanceHead moves the head pointer to the next position in the circular buffer.
func (b *Buffer) advanceHead() {
	b.head = (b.head + 1) % len(b.elements)
}
