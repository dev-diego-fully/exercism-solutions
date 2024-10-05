import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class TestTrack {

    public static void race(RemoteControlCar car) {
        car.drive();
    }

    public static List<ProductionRemoteControlCar> getRankedCars(List<ProductionRemoteControlCar> cars) {
        List<ProductionRemoteControlCar> rankedCars = List.copyOf(cars);

        rankedCars.sort((a,b) -> b.compareTo(a));
        
        return rankedCars;
    }
}
