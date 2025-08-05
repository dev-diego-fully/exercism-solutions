/// <summary>
/// A static class to compute the number of steps for a given number
/// to reach 1 according to the rules of the Collatz Conjecture.
/// </summary>
public static class CollatzConjecture
{
    /// <summary>
    /// Calculates the number of steps required for a positive integer to reach 1
    /// following the Collatz sequence.
    /// </summary>
    /// <param name="number">A positive integer to start the sequence.</param>
    /// <returns>The number of steps to reach 1.</returns>
    /// <exception cref="ArgumentOutOfRangeException">Thrown if the number is not positive.</exception>
    public static int Steps(int number)
    {
        const string nonPositiveErrorMessage = "Only positive numbers are allowed.";

        if (number <= 0)
        {
            throw new ArgumentOutOfRangeException(nonPositiveErrorMessage);
        }

        var steps = 0;
        
        for (var current = number; current > 1; current = Collatz(current))
        {
            steps++;
        }

        return steps;
    }

    /// <summary>
    /// Applies the Collatz rule to a given number.
    /// If the number is even, it is divided by 2.
    /// If the number is odd, it is multiplied by 3 and 1 is added.
    /// </summary>
    /// <param name="number">The number to apply the rule to.</param>
    /// <returns>The next number in the Collatz sequence.</returns>
    public static int Collatz(int number)
        => number % 2 == 0 ? number / 2 : 3 * number + 1;
}