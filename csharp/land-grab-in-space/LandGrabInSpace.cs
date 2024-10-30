using System;
using System.Collections.Generic;
using System.Linq;

public struct Coord
{
    public Coord(ushort x, ushort y)
    {
        X = x;
        Y = y;
    }

    public ushort X { get; }
    public ushort Y { get; }

    public static ushort Distance(Coord a, Coord b)
        => (ushort)Math.Sqrt(Math.Pow(a.X - b.X, 2) + Math.Pow(a.Y - b.Y, 2));
}

public struct Plot
{

    public Coord a, b, c, d;

    public Plot(Coord a, Coord b, Coord c, Coord d)
    {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
    }

    private ushort[] GetSides()
        => [
            Coord.Distance(a, b), Coord.Distance(b, c),
            Coord.Distance(c, d), Coord.Distance(d, a)
        ];

    public ushort GetLongestSide()
        => GetSides().Max();

}


public class ClaimsHandler
{

    private HashSet<Plot> ClaimedPlots = new();

    public void StakeClaim(Plot plot)
        => this.ClaimedPlots.Add(plot);

    public bool IsClaimStaked(Plot plot)
        => this.ClaimedPlots.Contains(plot);

    public bool IsLastClaim(Plot plot)
        => this.ClaimedPlots.Last().Equals(plot);

    public Plot GetClaimWithLongestSide()
    {
        Plot withLongest = this.ClaimedPlots.First();
        foreach (Plot plot in ClaimedPlots)
        {
            if (plot.GetLongestSide() > withLongest.GetLongestSide())
            {
                withLongest = plot;
            }
        }
        return withLongest;
    }
}
