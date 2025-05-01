public static class Gigasecond
{
    /// <summary>
    /// One giga is equivalent to one billion
    /// </summary>
    private static readonly int GIGA = 1_000_000_000;
    /// <summary>
    /// Calculates the exact moment when it will be one gigasecond after the
    /// given date.
    /// </summary>
    /// <param name="moment">
    /// A moment chosen to calculate the gigaversary.
    /// </param>
    /// <returns>Gigaversary of the given moment</returns>
    public static DateTime Add(DateTime moment)
        => moment.AddSeconds(GIGA);
}