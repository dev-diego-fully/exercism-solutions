<?php

declare(strict_types=1);

/**
 * Clock
 *
 * This class implements a clock that stores time in minutes and handles operations
 * like adding or subtracting minutes, as well as representing the time in "HH:MM" format.
 * It manages time within a 24-hour cycle, wrapping around midnight.
 */
class Clock
{
    /**
     * @var int MINUTES_IN_HOUR The number of minutes in a single hour.
     */
    private const MINUTES_IN_HOUR = 60;
    /**
     * @var int HOURS_IN_DAY The number of hours in a full day.
     */
    private const HOURS_IN_DAY = 24;
    /**
     * @var int MINUTES_IN_DAY The total number of minutes in a full day (24 hours * 60 minutes).
     */
    private const MINUTES_IN_DAY = 24 * self::MINUTES_IN_HOUR;

    /**
     * @var int The total time in minutes from midnight, adjusted to be within a 24-hour cycle.
     */
    private int $time;

    /**
     * Adds a specified number of minutes to the clock's current time.
     *
     * This method returns a *new* `Clock` instance with the updated time,
     * leaving the original `Clock` instance unchanged.
     *
     * @param int $minutes The number of minutes to add. Can be positive or negative.
     * @return Clock A new `Clock` instance representing the time after addition.
     *
     * @example
     * $clock = new Clock(10); $clock->add(3);    // Returns a Clock representing "10:03"
     * $clock = new Clock(10); $clock->add(61);   // Returns a Clock representing "11:01"
     * $clock = new Clock(23, 30); $clock->add(60); // Returns a Clock representing "00:30"
     * $clock = new Clock(6, 15); $clock->add(-160); // Returns a Clock representing "03:35"
     */
    public function add(int $minutes): Clock
    {
        return new self($this->hours(), $this->minutes() + $minutes);
    }

    /**
     * Subtracts a specified number of minutes from the clock's current time.
     *
     * This method returns a *new* `Clock` instance with the updated time,
     * leaving the original `Clock` instance unchanged.
     *
     * @param int $minutes The number of minutes to subtract.
     * @return Clock A new `Clock` instance representing the time after subtraction.
     *
     * @example
     * $clock = new Clock(10); $clock->sub(90);   // Returns a Clock representing "08:30"
     * $clock = new Clock(0, 30); $clock->sub(60); // Returns a Clock representing "23:30"
     */
    public function sub(int $minutes): Clock
    {
        return new self($this->hours(), $this->minutes() - $minutes);
    }

    /**
     * Constructs a new Clock instance.
     *
     * The time is normalized to fit within a 24-hour cycle.
     *
     * @param int $hours The initial hours (defaults to 0). Can be negative or greater than 23.
     * @param int $minutes The initial minutes (defaults to 0). Can be negative or greater than 59.
     *
     * @example
     * new Clock(8);       // Represents "08:00"
     * new Clock(11, 9);   // Represents "11:09"
     * new Clock(-2, 40);  // Represents "22:40"
     * new Clock(99, 11);  // Represents "03:11"
     * new Clock(2, 4322); // Represents "02:02"
     */
    public function __construct(int $hours = 0, int $minutes = 0)
    {
        $this->time = mod($hours * self::MINUTES_IN_HOUR + $minutes, self::MINUTES_IN_DAY);
    }

    /**
     * Returns the string representation of the clock's time in "HH:MM" format.
     *
     * Hours and minutes are always formatted with two digits, padded with a leading zero if necessary.
     *
     * @return string The formatted time string.
     *
     * @example
     * (new Clock(8))->__toString();    // Returns "08:00"
     * (new Clock(11, 9))->__toString(); // Returns "11:09"
     */
    public function __toString(): string
    {
        $hours = sprintf("%02d", $this->hours());
        $minutes = sprintf("%02d", $this->minutes());

        return "$hours:$minutes";
    }

    /**
     * Calculates the current hour (0-23) from the internal `time` in minutes.
     *
     * @return int The current hour.
     */
    private function hours(): int
    {
        return (int) ($this->time / self::MINUTES_IN_HOUR);
    }

    /**
     * Calculates the current minutes (0-59) from the internal `time` in minutes.
     *
     * @return int The current minutes.
     */
    private function minutes(): int
    {
        return $this->time % self::MINUTES_IN_HOUR;
    }
}

/**
 * Custom modulo function that handles negative numbers correctly for cyclic operations.
 *
 * Unlike PHP's default `%` operator, this function ensures the result is always
 * non-negative and within the range `[0, divisor - 1]`.
 *
 * @param int $value The number to operate on.
 * @param int $divisor The divisor. Must be a positive integer.
 * @return int The result of the modulo operation, always non-negative.
 */
function mod(int $value, int $divisor): int
{
    if ($divisor === 0) {
        return 0;
    }
    if ($value < 0) {
        return $divisor + $value % $divisor;
    }
    return $value % $divisor;
}