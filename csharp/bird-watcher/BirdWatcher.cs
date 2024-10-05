using System;
using System.Linq;

class BirdCount
{
    private int[] birdsPerDay;

    public BirdCount(int[] birdsPerDay)
    {
        this.birdsPerDay = birdsPerDay;
    }

    public static int[] LastWeek() => [0, 2, 5, 3, 7, 8, 4];

    public int Today() => this.birdsPerDay.Last();

    public void IncrementTodaysCount()
    {
        this.birdsPerDay[this.birdsPerDay.Length - 1]++;
    }

    public bool HasDayWithoutBirds()
    {
        foreach (int birdInDay in this.birdsPerDay)
        {
            if (birdInDay == 0)
                return true;
        }

        return false;

    }

    public int CountForFirstDays(int numberOfDays)
    {
        int daysChecked = Math.Min(numberOfDays, this.birdsPerDay.Length);
        int count = 0;

        for (int i = 0; i < daysChecked; i++)
        {
            count += this.birdsPerDay[i];
        }

        return count;
    }

    public int BusyDays()
    {   
        int birdsForABusyDay = 5;
        int busyDays = 0;

        foreach (int birdsInDay in this.birdsPerDay)
        {
            if (birdsInDay >= birdsForABusyDay)
                busyDays++;
        }

        return busyDays;
    }
}
