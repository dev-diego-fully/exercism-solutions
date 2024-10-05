using System;
using System.Net.Http.Headers;
using Xunit.Sdk;

class RemoteControlCar
{
    private int BatteryLevel = 100;
    private int TravelledDistance = 0;

    public RemoteControlCar() {

        this.BatteryLevel = 100;
        this.TravelledDistance = 0;

    }

    public static RemoteControlCar Buy()
    {
        return new RemoteControlCar();
    }

    public string DistanceDisplay()
        => $"Driven {this.TravelledDistance} meters";

    public string BatteryDisplay()
    {   
        if(this.BatteryLevel > 0)
            return $"Battery at {this.BatteryLevel}%";

        return "Battery empty";
    }

    public void Drive()
    {
        if( this.BatteryLevel > 0 ) {
            this.BatteryLevel -= 1;
            this.TravelledDistance += 20;
        }
    }
}
