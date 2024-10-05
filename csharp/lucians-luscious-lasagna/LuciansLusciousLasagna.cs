using System;

class Lasagna
{

    public int ExpectedMinutesInOven() {
        return 40;
    }

    public int RemainingMinutesInOven( int minutes ) {
        
        const int minMinutes = 0;

        return Math.Max( this.ExpectedMinutesInOven() - minutes, minMinutes );

    }

    public int PreparationTimeInMinutes( int layersNumber ) {

        const int minsForLayer = 2;

        return layersNumber * minsForLayer;

    }

    public int ElapsedTimeInMinutes( int layersNumber, int timeInOven ) {

        return PreparationTimeInMinutes( layersNumber ) + timeInOven;

    }
 
}
