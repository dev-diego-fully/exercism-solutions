/// <summary>
/// Provides functionality to count the occurrences of each nucleotide in a DNA sequence.
/// </summary>
public static class NucleotideCount
{
    /// <summary>
    /// Counts the occurrences of each nucleotide in the given DNA sequence.
    /// </summary>
    /// <param name="sequence">The DNA sequence as a string.</param>
    /// <returns>
    /// An <see cref="IDictionary{TKey, TValue}"/> containing the count of each nucleotide ('A', 'T', 'C', 'G').
    /// </returns>
    /// <exception cref="ArgumentException">
    /// Thrown if the sequence contains an invalid character that is not a valid nucleotide.
    /// </exception>
    public static IDictionary<char, int> Count(string sequence)
    {
        var counter = NucleotideCounter();

        foreach (char candidate in sequence)
        {
            if (!IsNucleotidade(candidate))
            {
                throw new ArgumentException("");
            }
            counter[candidate]++;
        }

        return counter;
    }

    /// <summary>
    /// Determines whether a character is a valid nucleotide.
    /// </summary>
    /// <param name="candidate">The character to check.</param>
    /// <returns>True if the character is 'A', 'T', 'C', or 'G'; otherwise, false.</returns>
    private static bool IsNucleotidade(char candidate)
        => candidate switch
        {
            'A' or 'T' or 'C' or 'G' => true,
            _ => false
        };

    /// <summary>
    /// Initializes a new dictionary to serve as a nucleotide counter.
    /// </summary>
    /// <returns>A new dictionary with each nucleotide key initialized to a count of zero.</returns>
    private static IDictionary<char, int> NucleotideCounter()
        => new Dictionary<char, int> {
            { 'A', 0 }, { 'T', 0 }, { 'C', 0 }, { 'G', 0 }
        };
}