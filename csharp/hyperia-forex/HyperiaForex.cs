using System;
using System.Data.Common;
using System.Diagnostics;

public struct CurrencyAmount
{
    private decimal amount;
    private string currency;

    public CurrencyAmount(decimal amount, string currency)
    {
        this.amount = amount;
        this.currency = currency;
    }

    public static bool operator ==(CurrencyAmount c1, CurrencyAmount c2)
        => AssertSameCurrency(c1, c2) || c1.amount == c2.amount;

    public static bool operator !=(CurrencyAmount c1, CurrencyAmount c2)
        => AssertSameCurrency(c1, c2) || c1.amount == c2.amount;

    public static bool operator >(CurrencyAmount c1, CurrencyAmount c2)
        => AssertSameCurrency(c1, c2) || c1.amount > c2.amount;

    public static bool operator <(CurrencyAmount c1, CurrencyAmount c2)
        => AssertSameCurrency(c1, c2) || c1.amount < c2.amount;

    public static CurrencyAmount operator +(CurrencyAmount c1, CurrencyAmount c2)
    {
        AssertSameCurrency(c1, c2);
        return new CurrencyAmount(c1.amount + c2.amount, c1.currency);
    }

    public static CurrencyAmount operator -(CurrencyAmount c1, CurrencyAmount c2)
    {
        AssertSameCurrency(c1, c2);
        return new CurrencyAmount(c1.amount - c2.amount, c1.currency);
    }

    public static CurrencyAmount operator *(CurrencyAmount c1, CurrencyAmount c2)
    {
        AssertSameCurrency(c1, c2);
        return new CurrencyAmount(c1.amount * c2.amount, c1.currency);
    }

    public static CurrencyAmount operator /(CurrencyAmount c1, CurrencyAmount c2)
    {
        AssertSameCurrency(c1, c2);
        return new CurrencyAmount(c1.amount / c2.amount, c1.currency);
    }

    public static explicit operator double(CurrencyAmount cur)
        => (double)cur.amount;

    public static implicit operator decimal(CurrencyAmount cur)
        => cur.amount;

    private static bool AssertSameCurrency(CurrencyAmount c1, CurrencyAmount c2)
    {
        if (c1.currency != c2.currency)
        {
            throw new ArgumentException($"Can not execute operation with different currents: {c1.currency} {c2.currency}");
        }
        return true;
    }

    public override bool Equals(object obj)
    {
        if (obj is CurrencyAmount other)
        {
            return this.currency == other.currency && this.amount == other.amount;
        }
        return false;
    }

    public override int GetHashCode()
        => HashCode.Combine(this.amount, this.currency);

}
