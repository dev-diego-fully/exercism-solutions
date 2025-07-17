//! A singly linked list implementation.

/// A type alias for a link in the linked list, representing an optional box containing a node.
type Link<T> = Option<Box<Node<T>>>;

/// Represents a simple singly linked list.
pub struct SimpleLinkedList<T> {
    /// The head of the linked list.
    head: Link<T>,
    /// The number of elements in the linked list.
    length: usize,
}

impl<T> SimpleLinkedList<T> {
    /// Creates a new, empty `SimpleLinkedList`.
    pub fn new() -> Self {
        Self {
            head: None,
            length: 0,
        }
    }

    /// Returns `true` if the linked list contains no elements.
    pub fn is_empty(&self) -> bool {
        self.length == 0
    }

    /// Returns the number of elements in the linked list.
    pub fn len(&self) -> usize {
        self.length
    }

    /// Appends an `element` to the front of the linked list.
    pub fn push(&mut self, element: T) {
        self.head = Node::link(element, self.head.take());
        self.length += 1;
    }

    /// Removes and returns the first element from the linked list.
    ///
    /// Returns `None` if the list is empty.
    pub fn pop(&mut self) -> Option<T> {
        let node = self.head.take()?;

        let value = node.value;
        self.head = node.next;
        self.length -= 1;

        Some(value)
    }

    /// Returns a reference to the first element without removing it.
    ///
    /// Returns `None` if the list is empty.
    pub fn peek(&self) -> Option<&T> {
        self.head.as_ref().map(|head| &head.value)
    }

    /// Reverses the order of elements in the linked list.
    pub fn rev(self) -> SimpleLinkedList<T> {
        let mut reversed = Self::new();
        let mut current = self.head;

        loop {
            match current {
                Some(node) => {
                    reversed.push(node.value);
                    current = node.next;
                }
                None => return reversed,
            }
        }
    }
}

impl<T> FromIterator<T> for SimpleLinkedList<T> {
    /// Creates a `SimpleLinkedList` from an iterator.
    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
        let mut new = Self::new();

        iter.into_iter().for_each(|element| new.push(element));

        new
    }
}

impl<T> From<SimpleLinkedList<T>> for Vec<T> {
    /// Converts a `SimpleLinkedList` into a `Vec`.
    fn from(linked_list: SimpleLinkedList<T>) -> Vec<T> {
        let mut vec = Vec::new();
        let mut current = linked_list.head;

        loop {
            match current {
                Some(node) => {
                    vec.insert(0, node.value);
                    current = node.next;
                }
                None => return vec,
            }
        }
    }
}

/// Represents a node in the singly linked list.
struct Node<T> {
    /// The value stored in the node.
    value: T,
    /// The next node in the list.
    next: Link<T>,
}

impl<T> Node<T> {
    /// Creates a new `Node`.
    fn new(element: T, next: Link<T>) -> Self {
        Self {
            value: element,
            next,
        }
    }

    /// Creates a new `Node` wrapped in a `Box`.
    fn boxed(element: T, next: Link<T>) -> Box<Self> {
        Box::new(Self::new(element, next))
    }

    /// Creates a new `Link` (an `Option<Box<Node<T>>>`) from an element and the next link.
    fn link(element: T, next: Link<T>) -> Link<T> {
        Some(Self::boxed(element, next))
    }
}