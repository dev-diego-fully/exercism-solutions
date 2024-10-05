using System;

public class Player
{
    private Random random = new Random();
    private int diceFaces = 18;
    private int maxSpellStrength = 100;

    public int RollDie()
        => this.random.Next(1, this.diceFaces + 1);

    public double GenerateSpellStrength()
        => this.random.NextDouble() * this.maxSpellStrength;
    
}
