/// <summary>
/// A static class to calculate the Hamming distance between two strings.
/// </summary>
public static class Hamming
{
    /// <summary>
    /// Calculates the Hamming distance between two DNA strands.
    /// </summary>
    /// <remarks>
    /// The Hamming distance is the number of positions at which the corresponding symbols are different.
    /// This method is only defined for strands of equal length.
    /// </remarks>
    /// <param name="firstStrand">The first DNA strand.</param>
    /// <param name="secondStrand">The second DNA strand.</param>
    /// <returns>The Hamming distance between the two strands.</returns>
    /// <exception cref="ArgumentException">Thrown when the strands have different lengths.</exception>
    public static int Distance(string firstStrand, string secondStrand)
    {
        const string errorMessage = "It is not possible to calculate the clamping distance for ropes of different sizes.";
        if (firstStrand.Length != secondStrand.Length)
        {
            throw new ArgumentException(errorMessage);
        }
        int hamming = 0;

        for (int i = 0; i < firstStrand.Length; i++)
        {
            if (firstStrand[i] != secondStrand[i])
            {
                hamming++;
            }
        }

        return hamming;
    }
}