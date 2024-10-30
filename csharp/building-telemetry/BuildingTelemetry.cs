using System;

public class RemoteControlCar
{
    private int batteryPercentage = 100;
    private int distanceDrivenInMeters = 0;
    private string[] sponsors = new string[0];
    private int latestSerialNum = 0;

    public void Drive()
    {
        if (batteryPercentage > 0)
        {
            batteryPercentage -= 10;
            distanceDrivenInMeters += 2;
        }
    }

    public void SetSponsors(params string[] sponsors)
        => this.sponsors = sponsors;

    public string DisplaySponsor(int sponsorNum)
        => this.sponsors[sponsorNum];

    public bool GetTelemetryData(ref int serialNum, out int batteryPercentage, out int distanceDrivenInMeters)
    {
        if (serialNum < this.latestSerialNum)
        {
            serialNum = this.latestSerialNum;
            batteryPercentage = -1;
            distanceDrivenInMeters = -1;
            return false;
        }
        this.latestSerialNum = serialNum;
        batteryPercentage = this.batteryPercentage;
        distanceDrivenInMeters = this.distanceDrivenInMeters;
        return true;
    }

    public static RemoteControlCar Buy() => new RemoteControlCar();
}

public class TelemetryClient
{
    private RemoteControlCar car;

    public TelemetryClient(RemoteControlCar car)
        => this.car = car;

    public string GetBatteryUsagePerMeter(int serialNum)
    {
        int batteryPercentage = 0, distanceDrivenInMeters = 0;
        bool telemetrySucceed = this.car.GetTelemetryData(
            ref serialNum, out batteryPercentage, out distanceDrivenInMeters
        );
        bool carDrived = distanceDrivenInMeters > 0;
        if (telemetrySucceed && carDrived)
        {
            int batteryPerMeter = (100 - batteryPercentage) / distanceDrivenInMeters;
            return $"usage-per-meter={batteryPerMeter}";
        }
        return "no data";
    }
}
