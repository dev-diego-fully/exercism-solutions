using System;
using System.Numerics;


class RemoteControlCar
{

    private int speed = 0;
    private int batteryDrain = 0;
    private int distanceDrived = 0;
    private int battery = 100;

    public RemoteControlCar(int speed, int batteryDrain)
    {
        this.speed = speed;
        this.batteryDrain = batteryDrain;

    }

    public bool BatteryDrained()
        => this.battery < this.batteryDrain;

    public int DistanceDriven()
        => this.distanceDrived;

    public void Drive()
    {
        if(!this.BatteryDrained()) {
            this.distanceDrived += this.speed;
            this.battery -= this.batteryDrain;
        }

    }

    public static RemoteControlCar Nitro()
        => new RemoteControlCar(50, 4);
}

class RaceTrack
{
    int distance = 0;

    public RaceTrack(int distance)
    {
        this.distance = distance;
    }

    public bool TryFinishTrack(RemoteControlCar car)
    {
        while (car.DistanceDriven() < this.distance)
        {
            if (car.BatteryDrained())
                return false;

            car.Drive();
        }

        return true;

    }
}
