import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

class AppointmentScheduler {
    public LocalDateTime schedule(String appointmentDateDescription) {
        final DateTimeFormatter formater = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss");
        return LocalDateTime.parse(appointmentDateDescription, formater);
    }

    public boolean hasPassed(LocalDateTime appointmentDate) {
        return appointmentDate.isBefore(LocalDateTime.now());
    }

    public boolean isAfternoonAppointment(LocalDateTime appointmentDate) {
        int hour = appointmentDate.getHour();

        return 12 <= hour && hour < 18;
    }

    public String getDescription(LocalDateTime appointmentDate) {
        final DateTimeFormatter descriptionTemplate = DateTimeFormatter.ofPattern(
                "'You have an appointment on' EEEE, MMMM d, yyyy, 'at' h:mm a.");

        return appointmentDate.format(descriptionTemplate);
    }

    public LocalDate getAnniversaryDate() {
        LocalDate currentYearAnniversary = LocalDate.of(
            LocalDate.now().getYear(), 9, 15
        );

        if (currentYearAnniversary.isBefore(LocalDate.now())) {
            return currentYearAnniversary.plusYears(1);
        }
        return currentYearAnniversary;
    }
}
