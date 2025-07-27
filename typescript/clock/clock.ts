/**
 * Clock
 *
 * This class represents a clock that handles time without dates, allowing
 * for operations like adding/subtracting minutes and comparing clock times.
 * It normalizes time to a 24-hour format internally.
 */
export class Clock {
  /**
   * @var MINUTES_IN_HOUR The number of minutes in a single hour.
   */
  private static MINUTES_IN_HOUR: number = 60;
  /**
   * @var HOURS_IN_DAY The number of hours in a full day.
   */
  private static HOURS_IN_DAY: number = 24;
  /**
   * @var MINUTES_IN_DAY The total number of minutes in a full day (24 hours * 60 minutes/hour).
   */
  private static MINUTES_IN_DAY: number = this.HOURS_IN_DAY * this.MINUTES_IN_HOUR;

  /**
   * @var stamp The internal representation of the time in total minutes from midnight.
   * This value is always normalized within the range [0, MINUTES_IN_DAY - 1].
   */
  private stamp: number;

  /**
   * Creates a new Clock instance.
   *
   * The hour and minute values are combined and normalized to fit within a 24-hour cycle.
   *
   * @param hour The hour component (0-23, but can be outside this range and will be normalized).
   * @param minute The minute component (0-59, but can be outside this range and will be normalized). Defaults to 0.
   */
  constructor(hour: number, minute: number = 0) {
    this.stamp = mod(hour * Clock.MINUTES_IN_HOUR + minute, Clock.MINUTES_IN_DAY);
  }

  /**
   * Returns the clock time as a string in "HH:MM" format.
   *
   * Hours and minutes are padded with a leading zero if they are a single digit.
   *
   * @returns A string representation of the clock time.
   */
  public toString(): string {
    const hours = this.hours().toString().padStart(2, '0');
    const minutes = this.minutes().toString().padStart(2, '0');

    return `${hours}:${minutes}`;
  }

  /**
   * Creates a new Clock instance representing the current time plus a specified number of minutes.
   *
   * The minutes can be positive (to add time) or negative (to subtract time).
   *
   * @param minutes The number of minutes to add to the clock.
   * @returns A new Clock instance with the updated time.
   */
  public plus(minutes: number): Clock {
    return new Clock(0, this.stamp + minutes);
  }

  /**
   * Creates a new Clock instance representing the current time minus a specified number of minutes.
   *
   * This is effectively the same as adding a negative number of minutes.
   *
   * @param minutes The number of minutes to subtract from the clock.
   * @returns A new Clock instance with the updated time.
   */
  public minus(minutes: number): Clock {
    return new Clock(0, this.stamp - minutes);
  }

  /**
   * Compares this Clock instance with another Clock instance for equality.
   *
   * Two clocks are considered equal if they represent the exact same time (i.e., have the same internal stamp).
   *
   * @param other The other Clock instance to compare with.
   * @returns True if the clocks represent the same time, false otherwise.
   */
  public equals(other: Clock): boolean {
    return this.stamp === other.stamp;
  }

  /**
   * Calculates the hour component of the clock's current time.
   *
   * @returns The current hour (0-23).
   */
  private hours(): number {
    return Math.floor(this.stamp / Clock.MINUTES_IN_HOUR);
  }

  /**
   * Calculates the minute component of the clock's current time.
   *
   * @returns The current minute (0-59).
   */
  private minutes(): number {
    return this.stamp % Clock.MINUTES_IN_HOUR;
  }
}

/**
 * Calculates the modulo of a value with a divisor, ensuring a positive result.
 *
 * This function handles negative `value` inputs correctly, returning a result
 * that is always within the range [0, divisor - 1].
 *
 * @param value The number to apply the modulo operation to.
 * @param divisor The divisor.
 * @returns The positive remainder of the division.
 */
function mod(value: number, divisor: number): number {
  const rem = value % divisor;
  const pad = value >= 0 ? 0 : divisor;

  return pad + rem;
}