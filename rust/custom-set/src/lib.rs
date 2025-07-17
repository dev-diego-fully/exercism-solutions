//! A custom set implementation using a `HashMap` for storage.

use std::collections::HashMap;
use std::hash::Hash;

/// Represents a custom set data structure.
///
/// This set is implemented using a `HashMap` where keys are the elements
/// and values are unused booleans (`true`).
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
    /// Returns an iterator over the elements of the set.
    fn elements(&self) -> impl Iterator<Item = &T> {
        self.inner.keys()
    }

    /// Creates a new `CustomSet` from a slice of elements.
    ///
    /// Duplicate elements in the input slice will result in a set
    /// containing only unique occurrences.
    pub fn new(input: &[T]) -> Self {
        let mut set = Self {
            inner: HashMap::new(),
        };

        input.iter().for_each(|element| set.add(element.clone()));

        set
    }

    /// Checks if the set contains a specific element.
    ///
    /// # Arguments
    ///
    /// * `element` - A reference to the element to check for.
    ///
    /// # Returns
    ///
    /// * `true` if the element is in the set, `false` otherwise.
    pub fn contains(&self, element: &T) -> bool {
        self.inner.contains_key(element)
    }

    /// Adds an element to the set.
    ///
    /// If the element already exists in the set, the operation has no effect.
    ///
    /// # Arguments
    ///
    /// * `element` - The element to add to the set.
    pub fn add(&mut self, element: T) {
        self.inner.insert(element, true);
    }

    /// Checks if this set is a subset of another set.
    ///
    /// A set `A` is a subset of `B` if every element in `A` is also in `B`.
    ///
    /// # Arguments
    ///
    /// * `other` - A reference to the other set.
    ///
    /// # Returns
    ///
    /// * `true` if this set is a subset of `other`, `false` otherwise.
    pub fn is_subset(&self, other: &Self) -> bool {
        self.elements().all(|e| other.contains(e))
    }

    /// Checks if the set contains no elements.
    ///
    /// # Returns
    ///
    /// * `true` if the set is empty, `false` otherwise.
    pub fn is_empty(&self) -> bool {
        self.inner.is_empty()
    }

    /// Checks if this set has no elements in common with another set.
    ///
    /// # Arguments
    ///
    /// * `other` - A reference to the other set.
    ///
    /// # Returns
    ///
    /// * `true` if the sets are disjoint (have no common elements), `false` otherwise.
    pub fn is_disjoint(&self, other: &Self) -> bool {
        self.elements().all(|e| !other.contains(e))
    }

    /// Returns a new set containing elements common to both this set and another set.
    ///
    /// This operation performs set intersection.
    ///
    /// # Arguments
    ///
    /// * `other` - A reference to the other set.
    ///
    /// # Returns
    ///
    /// * A new `CustomSet` containing the intersection of the two sets.
    pub fn intersection(&self, other: &Self) -> Self {
        let elements: Vec<T> = self
            .elements()
            .filter(|&element| other.contains(element))
            .cloned()
            .collect();

        Self::new(&elements)
    }

    /// Returns a new set containing elements present in this set but not in another set.
    ///
    /// This operation performs set difference (A - B).
    ///
    /// # Arguments
    ///
    /// * `other` - A reference to the other set.
    ///
    /// # Returns
    ///
    /// * A new `CustomSet` containing the difference of the two sets.
    pub fn difference(&self, other: &Self) -> Self {
        let elements: Vec<T> = self
            .elements()
            .filter(|&element| !other.contains(element))
            .cloned()
            .collect();

        Self::new(&elements)
    }

    /// Returns a new set containing all elements from both this set and another set.
    ///
    /// This operation performs set union.
    ///
    /// # Arguments
    ///
    /// * `other` - A reference to the other set.
    ///
    /// # Returns
    ///
    /// * A new `CustomSet` containing the union of the two sets.
    pub fn union(&self, other: &Self) -> Self {
        let elements: Vec<T> = self.elements().chain(other.elements()).cloned().collect();

        Self::new(&elements)
    }
}