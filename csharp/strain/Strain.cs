using System;
using System.Collections.Generic;

/// <summary>
/// A static class containing extension methods for filtering an <see cref="IEnumerable{T}"/> collection.
/// These methods provide custom implementations for keeping or discarding elements based on a predicate.
/// </summary>
public static class Strain
{
    /// <summary>
    /// Filters a collection, keeping only the elements for which the provided predicate returns true.
    /// </summary>
    /// <typeparam name="T">The type of the elements in the collection.</typeparam>
    /// <param name="collection">The source collection to be filtered.</param>
    /// <param name="predicate">A function that returns true for elements to be kept.</param>
    /// <returns>An <see cref="IEnumerable{T}"/> containing only the elements that satisfy the predicate.</returns>
    public static IEnumerable<T> Keep<T>(this IEnumerable<T> collection, Func<T, bool> predicate)
    {
        foreach (var item in collection)
        {
            if (predicate(item))
            {
                yield return item;
            }
        }
    }

    /// <summary>
    /// Filters a collection, discarding the elements for which the provided predicate returns true.
    /// This is the inverse of the <see cref="Keep{T}(IEnumerable{T}, Func{T, bool})"/> method.
    /// </summary>
    /// <typeparam name="T">The type of the elements in the collection.</typeparam>
    /// <param name="collection">The source collection to be filtered.</param>
    /// <param name="predicate">A function that returns true for elements to be discarded.</param>
    /// <returns>An <see cref="IEnumerable{T}"/> containing only the elements that do not satisfy the predicate.</returns>
    public static IEnumerable<T> Discard<T>(this IEnumerable<T> collection, Func<T, bool> predicate)
    {
        foreach (var item in collection)
        {
            if (!predicate(item))
            {
                yield return item;
            }
        }
    }
}