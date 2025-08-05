/// <summary>
/// A static class containing extension methods for processing collections.
/// </summary>
public static class AccumulateExtensions
{
    /// <summary>
    /// Applies a function to each element of a collection and returns a new collection
    /// with the results. This is similar to the LINQ Select method.
    /// </summary>
    /// <typeparam name="T">The type of the elements in the source collection.</typeparam>
    /// <typeparam name="U">The type of the elements in the returned collection.</typeparam>
    /// <param name="collection">The source collection to process.</param>
    /// <param name="func">A function to apply to each element of the collection.</param>
    /// <returns>An <see cref="IEnumerable{U}"/> containing the results of applying the function to each element.</returns>
    public static IEnumerable<U> Accumulate<T, U>(this IEnumerable<T> collection, Func<T, U> func)
    {
        foreach (var item in collection)
        {
            yield return func(item);
        }
    }
}