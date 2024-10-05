using System;

class WeighingMachine
{
    private double _weight;
    public double Precision { get; }
    public double TareAdjustment { get; set; } = 5;
    public double Weight
    {
        get { return this._weight; }
        set
        {
            if (value >= 0)
            {
                this._weight = value;
            }
            else
            {
                throw new ArgumentOutOfRangeException(value.ToString());
            }
        }
    }
    public string DisplayWeight
    {
        get
        {
            double displayed = this.Weight - this.TareAdjustment;
            // Arredonda o valor de 'displayed' para a precisão especificada
            double rounded = Math.Round(displayed, (int)this.Precision);
            return $"{rounded:F{(int)this.Precision}} kg";
        }
    }
    public WeighingMachine(double precision)
    {
        this.Precision = precision;
    }
}
