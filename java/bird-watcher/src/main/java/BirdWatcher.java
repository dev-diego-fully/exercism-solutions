import java.util.Arrays;

class BirdWatcher {
    private final int[] birdsPerDay;

    public BirdWatcher(int[] birdsPerDay) {
        this.birdsPerDay = birdsPerDay.clone();
    }

    public int[] getLastWeek() {
        int weekEnd = this.birdsPerDay.length;
        int weekStart = Math.max(0, weekEnd - 7);

        return Arrays.copyOfRange(this.birdsPerDay, weekStart, weekEnd);
    }

    public int getToday() {
        int today = this.birdsPerDay.length - 1;

        return this.birdsPerDay[today];
    }

    public void incrementTodaysCount() {
        int today = this.birdsPerDay.length - 1;

        this.birdsPerDay[today] += 1;
    }

    public boolean hasDayWithoutBirds() {
        for(int birdInDay: this.birdsPerDay) {
            if (birdInDay <= 0) {
                return true;
            }
        }
        return false;
    }

    public int getCountForFirstDays(int numberOfDays) {
        int daysNumber = Math.min(this.birdsPerDay.length, numberOfDays);
        int birdsCount = 0;

        for(int dayIndex = 0; dayIndex < daysNumber; dayIndex++) {
            birdsCount += this.birdsPerDay[dayIndex];
        }

        return birdsCount;
    }

    public int getBusyDays() {
        int busyDayCount = 0;

        for(int birdInDay: this.birdsPerDay) {
            if(birdInDay >= 5) {
                busyDayCount += 1;
            }
        }

        return busyDayCount;
    }
}
