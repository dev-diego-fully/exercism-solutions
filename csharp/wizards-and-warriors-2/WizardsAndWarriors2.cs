using System;

static class GameMaster
{
    public static string Describe(Character character)
        => $"You're a level {character.Level} {character.Class} with {character.HitPoints} hit points.";

    public static string Describe(Destination destination)
        => $"You've arrived at {destination.Name}, which has {destination.Inhabitants} inhabitants.";

    public static string Describe(TravelMethod travelMethod = TravelMethod.Walking)
        => travelMethod switch
        {
            TravelMethod.Walking => "You're traveling to your destination by walking.",
            TravelMethod.Horseback => "You're traveling to your destination on horseback.",
            _ => throw new NotImplementedException()
        };

    public static string Describe(Character character, Destination destination, TravelMethod travelMethod)
        => $"{Describe(character)} {Describe(travelMethod)} {Describe(destination)}";

    public static string Describe(Character character, Destination destination)
        => $"{Describe(character)} {Describe()} {Describe(destination)}";
}

class Character
{
    public string Class { get; set; }
    public int Level { get; set; }
    public int HitPoints { get; set; }
}

class Destination
{
    public string Name { get; set; }
    public int Inhabitants { get; set; }
}

enum TravelMethod
{
    Walking,
    Horseback
}
