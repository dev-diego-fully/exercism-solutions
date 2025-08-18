/// Maps each element of an input vector to a new value by applying a given function.
///
/// This is a generic function that takes a vector of type `T` and a closure or function
/// that transforms an element of type `T` into a new element of type `U`.
/// It returns a new vector containing the transformed elements.
///
/// # Arguments
///
/// * `input` - The vector to be mapped. The vector is consumed by the function.
/// * `function` - The mapping function to apply to each element. It takes an element of `T` by value
///   and returns an element of `U`.
///
/// # Returns
///
/// A new vector of type `U` containing the results of the mapping.
pub fn map<T, U>(input: Vec<T>, mut function: impl FnMut(T) -> U) -> Vec<U> {
    let mut result = Vec::with_capacity(input.len());

    for elem in input {
        result.push(function(elem));
    }

    result
}