using System;
using System.Reflection.Metadata;

static class AssemblyLine
{

    public static double SuccessRate(int speed)
    {
        if (speed <= 0) { 
            return 0.0;

        } else if (speed <= 4) { 
            return 1.0;

        } else if (speed <= 8) {
            return 0.90;

        } else if (speed == 9) {
            return 0.80;

        } else if (speed == 10) {
            return 0.77;

        } else {
            throw new ArgumentOutOfRangeException(speed.ToString());
        }
    }

    public static double ProductionRatePerHour(int speed)
    {
        const int carsPerHourAtSpeed1 = 221;

        return carsPerHourAtSpeed1 * speed * SuccessRate( speed );
    }

    public static int WorkingItemsPerMinute(int speed)
    {   
        const double minutesInHour = 60;

        return (int)(ProductionRatePerHour( speed ) / minutesInHour);

    }
}
