class Clock {

    private static final int MINUTES_IN_HOUR = 60;
    private static final int MINUTES_IN_DAY = 24 * MINUTES_IN_HOUR;
    private static final String CLOCK_FORMAT = "%02d:%02d";

    private int time;

    Clock(int hours, int minutes) {
        this.time = hours * MINUTES_IN_HOUR + minutes;
        this.clampTime();
    }

    public int getHours() {
        return this.time / MINUTES_IN_HOUR;
    }

    public int getMinutes() {
        return this.time % MINUTES_IN_HOUR;
    }

    void add(int minutes) {
        this.time += minutes;
        this.clampTime();
    }

    @Override
    public String toString() {
        return String.format(
                CLOCK_FORMAT, this.getHours(), this.getMinutes());
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Clock) {
            return this.equals((Clock) obj);
        }
        return false;
    }

    public boolean equals(Clock other) {
        return this.time == other.time;
    }

    private void clampTime() {
        this.time %= MINUTES_IN_DAY;

        if (this.time < 0) {
            this.time = MINUTES_IN_DAY + this.time;
        }
    }

}