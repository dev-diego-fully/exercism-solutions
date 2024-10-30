public class RemoteControlCar
{

    public class _Telemetry
    {
        private RemoteControlCar owner;

        public _Telemetry(RemoteControlCar owner)
        {
            this.owner = owner;
        }

        public void Calibrate()
        {

        }

        public bool SelfTest()
            => true;

        public void ShowSponsor(string sponsorName)
        {
            this.owner.SetSponsor(sponsorName);
        }

        public void SetSpeed(decimal amount, string unitsString)
        {
            SpeedUnits speedUnits = SpeedUnits.MetersPerSecond;
            if (unitsString == "cps")
            {
                speedUnits = SpeedUnits.CentimetersPerSecond;
            }

            this.owner.SetSpeed(new Speed(amount, speedUnits));
        }

    }

    private enum SpeedUnits
    {
        MetersPerSecond,
        CentimetersPerSecond
    }

    private struct Speed
    {
        public decimal Amount { get; }
        public SpeedUnits SpeedUnits { get; }

        public Speed(decimal amount, SpeedUnits speedUnits)
        {
            Amount = amount;
            SpeedUnits = speedUnits;
        }

        public override string ToString()
        {
            string unitsString = "meters per second";
            if (SpeedUnits == SpeedUnits.CentimetersPerSecond)
            {
                unitsString = "centimeters per second";
            }

            return $"{Amount} {unitsString}";
        }
    }

    public _Telemetry Telemetry;

    public string CurrentSponsor { get; private set; }

    private Speed currentSpeed;

    public RemoteControlCar()
    {
        this.Telemetry = new(this);
    }

    public string GetSpeed()
        => currentSpeed.ToString();

    private void SetSponsor(string sponsorName)
    {
        CurrentSponsor = sponsorName;
    }

    private void SetSpeed(Speed speed)
    {
        currentSpeed = speed;
    }
}