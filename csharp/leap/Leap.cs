public static class Leap
{
    /// <summary>
    /// Returns whether or not the given input year is a leap year.
    /// </summary>
    /// <param name="year">Year verified
    /// </param>
    /// <returns></returns>
    public static bool IsLeapYear(int year)
        => year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);

}