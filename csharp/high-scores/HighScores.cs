using System.Collections.Immutable;

/// <summary>
/// Class stores the scores already recorded by the player. Provides
/// methods to obtain these scores in a specific order or manner.
/// Does not modify the original score list, and is immutable.
/// </summary>
/// <param name="scores">List of scores recorded by a player.</param>
public class HighScores(List<int> scores)
{
    private readonly ImmutableList<int> scores = [.. scores];
    private readonly ImmutableList<int> best = [.. scores.OrderByDescending(x => x).Take(3)];

    /// <summary>
    /// Returns a list containing all records in recorded order. Changing
    /// this list does not change the original.
    /// </summary>
    /// <returns>
    /// Copy of the scores list
    /// </returns>
    public List<int> Scores()
        => [.. this.scores];

    /// <summary>
    /// Returns the last recorded score.
    /// If the score list is empty, it will throw an <see cref="InvalidOperationException"/>.
    /// </summary>
    /// <returns>The most recent score.</returns>
    public int Latest()
        => this.scores.Last();

    /// <summary>
    /// Returns the best score ever recorded (the highest)
    /// </summary>
    /// <returns>
    /// Highest score recorded
    /// </returns>
    public int PersonalBest()
        => this.best.First();

    /// <summary>
    /// Returns a list containing the best three scores ever recorded
    /// (the highest).
    /// </summary>
    /// <returns>
    /// Returns a list containing the best three scores ever recorded
    /// (the highest).
    /// </returns>
    public List<int> PersonalTopThree()
        => [.. this.best];
}