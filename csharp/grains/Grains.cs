/// <summary>
/// A static class to solve the classic "Grains of Wheat on a Chessboard" problem.
/// </summary>
public static class Grains
{
    /// <summary>
    /// Calculates the number of grains of wheat on a specific square of a chessboard.
    /// The number of grains doubles for each successive square.
    /// </summary>
    /// <param name="n">The square number (1 to 64).</param>
    /// <returns>The number of grains of wheat on the specified square.</returns>
    /// <exception cref="ArgumentOutOfRangeException">Thrown if the square number is not between 1 and 64.</exception>
    public static ulong Square(int n)
    {
        const string rangeErrorMessage = "A chessboard has squares only between 1 and 64.";
        const int minChessBoardSquare = 1;
        const int maxChessBoardSquare = 64;

        if (n < minChessBoardSquare || n > maxChessBoardSquare)
        {
            throw new ArgumentOutOfRangeException(rangeErrorMessage);
        }

        ulong exp = (ulong)(n - 1);

        return (ulong)Math.Pow(2UL, exp);
    }

    /// <summary>
    /// Calculates the total number of grains of wheat on the entire chessboard.
    /// </summary>
    /// <remarks>
    /// The total is equal to 2^64 - 1, which corresponds to the maximum value of a 64-bit unsigned integer.
    /// </remarks>
    /// <returns>The total number of grains on all 64 squares.</returns>
    public static ulong Total() => ulong.MaxValue;
}