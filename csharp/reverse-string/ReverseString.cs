/// <summary>
/// A static class that provides a method for reversing a string.
/// </summary>
public static class ReverseString
{
    /// <summary>
    /// Reverses the order of the characters in a given string.
    /// </summary>
    /// <param name="input">The string to be reversed.</param>
    /// <returns>A new string with the characters from the input string in reverse order.</returns>
    public static string Reverse(string input)
       => new([.. input.Reverse()]);

}