use std::collections::HashMap;
use std::hash::Hash;

#[derive(Debug, PartialEq, Eq)]
pub struct CustomSet<T>
where
    T: Eq + Hash + Clone,
{
    inner: HashMap<T, bool>,
}

impl<T> CustomSet<T>
where
    T: Eq + Hash + Clone,
{
    fn elements(&self) -> impl Iterator<Item = &T> {
        self.inner.keys()
    }

    pub fn new(input: &[T]) -> Self {
        let mut set = Self {
            inner: HashMap::new(),
        };

        input.iter().for_each(|element| set.add(element.clone()));

        set
    }

    pub fn contains(&self, element: &T) -> bool {
        self.inner.contains_key(element)
    }

    pub fn add(&mut self, element: T) {
        self.inner.insert(element, true);
    }

    pub fn is_subset(&self, other: &Self) -> bool {
        self.elements().all(|e|other.contains(e))
    }

    pub fn is_empty(&self) -> bool {
        self.inner.is_empty()
    }

    pub fn is_disjoint(&self, other: &Self) -> bool {
        self.elements().all(|e|!other.contains(e))
    }

    #[must_use]
    pub fn intersection(&self, other: &Self) -> Self {
        let elements: Vec<T> = self
            .elements()
            .filter(|&element| other.contains(element))
            .cloned()
            .collect();

        Self::new(&elements)
    }

    #[must_use]
    pub fn difference(&self, other: &Self) -> Self {
        let elements: Vec<T> = self
            .elements()
            .filter(|&element| !other.contains(element))
            .cloned()
            .collect();

        Self::new(&elements)
    }

    #[must_use]
    pub fn union(&self, other: &Self) -> Self {
        let elements: Vec<T> = self.elements().chain(other.elements()).cloned().collect();
        
        Self::new(&elements)
    }
}
