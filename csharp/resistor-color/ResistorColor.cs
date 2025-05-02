public static class ResistorColor
{

    /// <summary>
    /// List of register band colors. The indexes are equivalent to the
    /// numeric values ​​of the colors.
    /// </summary>
    private static readonly string[] COLORS = [
        "black", "brown", "red", "orange",
        "yellow", "green", "blue", "violet",
        "grey", "white"
    ];

    /// <summary>
    /// Returns the numeric value of the given color range (0 to 9).
    /// If the color is not a valid color range, returns -1
    /// </summary>
    /// <param name="color">Color of a resistor strip</param>
    /// <returns>Color code value, or -1 in case of invalid color</returns>
    public static int ColorCode(string color)
        => Array.IndexOf(Colors(), color);

    /// <summary>
    /// Returns a list containing all valid colors for the resistor band.
    /// The index of each color coincides with its numerical value.
    /// </summary>
    /// <returns>All valid resistor band colors.</returns>
    public static string[] Colors()
        => (string[])COLORS.Clone();
}