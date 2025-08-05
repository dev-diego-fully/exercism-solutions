/// <summary>
/// A static class that calculates the difference between the square of the sum
/// and the sum of the squares of the first N natural numbers.
/// </summary>
public static class DifferenceOfSquares
{
    /// <summary>
    /// Calculates the square of the sum of the first 'max' natural numbers.
    /// The formula for the sum of the first N natural numbers is n * (n + 1) / 2.
    /// </summary>
    /// <param name="max">The upper limit of the natural numbers.</param>
    /// <returns>The square of the sum of numbers from 1 to 'max'.</returns>
    public static int CalculateSquareOfSum(int max)
        => (square(max) * square(max + 1)) / 4;

    /// <summary>
    /// Calculates the sum of the squares of the first 'max' natural numbers.
    /// The formula for the sum of the squares of the first N natural numbers is n * (n + 1) * (2n + 1) / 6.
    /// </summary>
    /// <param name="max">The upper limit of the natural numbers.</param>
    /// <returns>The sum of the squares of numbers from 1 to 'max'.</returns>
    public static int CalculateSumOfSquares(int max)
        => (max * (max + 1) * (2 * max + 1)) / 6;

    /// <summary>
    /// Calculates the difference between the square of the sum and the sum of the squares
    /// of the first 'max' natural numbers.
    /// </summary>
    /// <param name="max">The upper limit of the natural numbers.</param>
    /// <returns>The difference between the two calculated values.</returns>
    public static int CalculateDifferenceOfSquares(int max)
        => CalculateSquareOfSum(max) - CalculateSumOfSquares(max);

    /// <summary>
    /// A private helper method to calculate the square of a number.
    /// </summary>
    /// <param name="n">The number to be squared.</param>
    /// <returns>The square of the number.</returns>
    private static int square(int n)
        => n * n;
}