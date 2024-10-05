using System;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices;


public enum Location
{
    NewYork,
    London,
    Paris
}

public enum AlertLevel
{
    Early,
    Standard,
    Late
}

public static class Appointment
{
    public static DateTime ShowLocalTime(DateTime dtUtc)
        => dtUtc.ToLocalTime();

    public static DateTime Schedule(string appointmentDateDescription, Location location)
    {
        DateTime dateTime = DateTime.Parse( appointmentDateDescription );
        string timeZone = location.TimeZoneId();

        return TimeZoneInfo.ConvertTimeBySystemTimeZoneId(dateTime, timeZone, "UTC");
    }

    public static DateTime GetAlertTime(DateTime appointment, AlertLevel alertLevel)
    {
        return alertLevel switch
        {
            AlertLevel.Early => appointment.AddDays(-1),
            AlertLevel.Standard => appointment.AddHours(-1).AddMinutes(-45),
            AlertLevel.Late => appointment.AddMinutes(-30),
            _ => throw new ArgumentException($"{appointment} {alertLevel}"),
        };
    }

    public static bool HasDaylightSavingChanged(DateTime dt, Location location)
    {
        DateTime weekEarly = dt.AddDays(-7);
        TimeZoneInfo info = location.ToTimeZoneInfo();

        bool dtDaylightSave = info.IsDaylightSavingTime(dt);
        bool weekEarlyDaylightSave = info.IsDaylightSavingTime(weekEarly);

        return dtDaylightSave != weekEarlyDaylightSave;
    }

    public static DateTime NormalizeDateTime(string dtStr, Location location)
    {
        CultureInfo cultureInfo = location.ToCultureInfo();
        bool successed = DateTime.TryParse(
            dtStr, cultureInfo, DateTimeStyles.None, out DateTime normalized
        );

        return successed ? normalized : DateTime.MinValue;
    }
    
    //privates
    private static CultureInfo ToCultureInfo(this Location location){
        return CultureInfo.GetCultureInfo(
            location switch
            {
                Location.NewYork => "en-US",
                Location.London => "en-GB",
                Location.Paris => "fr-FR",
                _ => throw new ArgumentException(location.ToString())
            }
        );
    }

    private static TimeZoneInfo ToTimeZoneInfo(this Location location)
    {
        string timeZoneId = location.TimeZoneId();

        return TimeZoneInfo.FindSystemTimeZoneById(timeZoneId);
    }

    private static string TimeZoneId(this Location location)
    {
        bool runOnWindows = RuntimeInformation.IsOSPlatform(
            OSPlatform.Windows
        );

        return location switch
        {
            Location.NewYork when runOnWindows => "Eastern Standard Time",
            Location.London when runOnWindows => "GMT Standard Time",
            Location.Paris when runOnWindows => "W. Europe Standard Time",
            Location.NewYork when !runOnWindows => "America/New_York",
            Location.London when !runOnWindows => "Europe/London",
            Location.Paris when !runOnWindows => "Europe/Paris",
            _ => throw new ArgumentException(location.ToString())
        };

    }

}
