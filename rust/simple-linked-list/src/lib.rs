type Link<T> = Option<Box<Node<T>>>;

pub struct SimpleLinkedList<T> {
    head: Link<T>,
    length: usize,
}

impl<T> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Self {
            head: None,
            length: 0,
        }
    }

    pub fn is_empty(&self) -> bool {
        self.length == 0
    }

    pub fn len(&self) -> usize {
        self.length
    }

    pub fn push(&mut self, element: T) {
        self.head = Node::link(element, self.head.take());
        self.length += 1;
    }

    pub fn pop(&mut self) -> Option<T> {
        let node = self.head.take()?;

        let value = node.value;
        self.head = node.next;
        self.length -= 1;

        Some(value)
    }

    pub fn peek(&self) -> Option<&T> {
        self.head.as_ref().map(|head| &head.value)
    }

    #[must_use]
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
    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
        let mut new = Self::new();

        iter.into_iter().for_each(|element| new.push(element));

        new
    }
}

impl<T> From<SimpleLinkedList<T>> for Vec<T> {
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

struct Node<T> {
    value: T,
    next: Link<T>,
}

impl<T> Node<T> {
    fn new(element: T, next: Link<T>) -> Self {
        Self {
            value: element,
            next,
        }
    }

    fn boxed(element: T, next: Link<T>) -> Box<Self> {
        Box::new(Self::new(element, next))
    }

    fn link(element: T, next: Link<T>) -> Link<T> {
        Some(Self::boxed(element, next))
    }
}
