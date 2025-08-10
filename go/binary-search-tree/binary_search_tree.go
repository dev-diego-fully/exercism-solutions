package binarysearchtree

// BinarySearchTree is tree structure that stores values in a naturally ordered manner, but does not have
// any type of balancing between the sides.
type BinarySearchTree struct {
	left  *BinarySearchTree
	data  int
	right *BinarySearchTree
}

// NewBst creates and returns a new BinarySearchTree.
func NewBst(i int) *BinarySearchTree {
	return &BinarySearchTree{data: i, left: nil, right: nil}
}

// Insert inserts an int into the BinarySearchTree.
// Inserts happen based on the rules of a binary search tree
func (bst *BinarySearchTree) Insert(i int) {
	current := bst
	for {
		goesLeft := i <= current.data
		if goesLeft && current.left == nil {
			current.left = NewBst(i)
			return
		}
		if !goesLeft && current.right == nil {
			current.right = NewBst(i)
			return
		}
		if goesLeft {
			current = current.left
		} else {
			current = current.right
		}
	}

}

// SortedData returns the ordered contents of BinarySearchTree as an []int.
// The values are in increasing order starting with the lowest int value.
// A BinarySearchTree that has the numbers [1,3,7,5] added will return the
// []int [1,3,5,7].
func (bst *BinarySearchTree) SortedData() []int {
	stack := []*BinarySearchTree{}
	sorted := []int{}

	for current := bst; current != nil || !isEmpty(&stack); {
		for current != nil {
			push(&stack, current)
			current = current.left
		}
		current, _ = pop(&stack)
		push(&sorted, current.data)
		current = current.right
	}

	return sorted
}
