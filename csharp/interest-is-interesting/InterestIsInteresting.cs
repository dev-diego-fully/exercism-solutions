using System;

static class SavingsAccount
{
    public static float InterestRate(decimal balance)
    {
        if (balance < 0)
            return 3.213f;

        if (balance < 1000)
            return 0.5f;

        if (balance < 5000)
            return 1.621f;

        return 2.475f;
    }

    public static decimal Interest(decimal balance)
    {
        decimal percent = 1.0m / 100m;
        decimal remaining = (decimal)(InterestRate(balance)) * percent;

        return balance * remaining;
    }

    public static decimal AnnualBalanceUpdate(decimal balance)
        => balance + Interest(balance);

    public static int YearsBeforeDesiredBalance(decimal balance, decimal targetBalance)
    {
        int years_needed = 0;
        decimal currentBalance = balance;

        while (currentBalance < targetBalance)
        {
            years_needed++;
            currentBalance = AnnualBalanceUpdate(currentBalance);
        }

        return years_needed;
    }
}
