/**
 * Represents a robot with a pseudo-randomly generated name.
 *
 * Each robot is given a unique name in the format 'LLDDD' (two letters followed by three digits),
 * such as 'RX837' or 'BC123'. The name is generated the first time it is accessed and can be reset.
 * Generated names are tracked to ensure no duplicates.
 */
export class Robot {
  /**
   * @var usedNames A static set to track all robot names that have been used.
   * This ensures each robot has a unique name.
   */
  private static usedNames: Set<string> = new Set();
  /**
   * @var TOTAL_NAMES The total number of possible unique names in the 'LLDDD' format.
   * 26 letters * 26 letters * 1000 numbers (from 000 to 999).
   */
  private static TOTAL_NAMES: number = 26 ** 2 * 10 ** 3;

  /**
   * @var _name The robot's name. It is `null` until the name is first accessed or after a reset.
   */
  private _name: string | null;

  /**
   * Creates a new Robot instance.
   *
   * The robot is initialized without a name, which will be generated on demand.
   */
  constructor() {
    this._name = null;
  }

  /**
   * Gets the robot's name.
   *
   * If the robot does not yet have a name, a new one is generated, added to the
   * set of used names, and returned. If all possible names have been used, an error is thrown.
   *
   * @returns The unique name of the robot.
   * @throws Error If all possible unique names have been used.
   */
  public get name(): string {
    if (this._name !== null) {
      return this._name;
    }
    if (Robot.usedNames.size === Robot.TOTAL_NAMES) {
      throw new Error("No more names available.");
    }
    this._name = this.randomName();
    Robot.usedNames.add(this._name);

    return this._name;
  }

  /**
   * Resets the robot's name.
   *
   * After a reset, the robot will have a new name generated the next time it's accessed.
   * The old name is not reused until all possible names are exhausted and the set of used names is cleared.
   */
  public resetName(): void {
    this._name = null;
  }

  /**
   * Releases all used robot names, allowing them to be reused.
   *
   * This is a static method and affects all robots.
   */
  public static releaseNames(): void {
    this.usedNames = new Set();
  }

  /**
   * Generates a random, unused name for the robot.
   *
   * The name is repeatedly generated until an unused name is found.
   *
   * @returns A unique robot name in the 'LLDDD' format.
   */
  private randomName(): string {
    let name = "";

    do {
      const firstLetter = randomLetter();
      const secondLetter = randomLetter();
      const number = 1 + randomIndex(999);
      const formatedNumber = number.toString().padStart(3, "0");

      name = `${firstLetter}${secondLetter}${formatedNumber}`;
    } while (name === "" || Robot.usedNames.has(name));

    return name;
  }
}

/**
 * Generates a random index from 0 up to (but not including) `length`.
 *
 * @param length The exclusive upper limit for the index.
 * @returns A random integer.
 */
function randomIndex(length: number): number {
  return Math.floor(length * Math.random());
}

/**
 * Generates a random uppercase letter from the alphabet.
 *
 * @returns A string containing a single uppercase letter.
 */
function randomLetter(): string {
  return ALPHABET[randomIndex(ALPHABET.length)];
}

/**
 * @const ALPHABET A string containing all uppercase letters of the alphabet.
 */
const ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";