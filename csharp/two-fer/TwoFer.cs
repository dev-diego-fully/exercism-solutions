public static class TwoFer
{
    /// <summary>
    /// Returns a message to greet a person when you give them the cookie.
    /// If you know their name, refer to them by their name, otherwise
    /// refer to them as "you".
    /// </summary>
    /// <param name="personName">Name of person, if known.</param>
    /// <returns>Message in the format "One for [person], one for me."</returns>
    public static string Speak(string personName = "you")
        => $"One for {personName}, one for me.";
}
