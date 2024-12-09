import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Gigasecond {

    private final LocalDateTime date;
    private final static int giga = (int) 1e9;

    public Gigasecond(LocalDate moment) {
        this.date = moment
                .atStartOfDay()
                .plusSeconds(giga);
    }

    public Gigasecond(LocalDateTime moment) {
        this.date = LocalDateTime
                .from(moment)
                .plusSeconds(giga);
    }

    public LocalDateTime getDateTime() {
        return LocalDateTime
                .from(this.date);
    }
}
