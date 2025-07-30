/**
 * Custom error class for handling invalid input.
 *
 * @extends Error
 */
export class InvalidInputError extends Error {
  /**
   * Creates a new InvalidInputError instance.
   *
   * @param message The error message. Defaults to 'Invalid Input'.
   */
  constructor(message: string) {
    super();
    this.message = message || 'Invalid Input';
  }
}

/**
 * @typedef {'north' | 'east' | 'south' | 'west'} Direction
 * Represents the four cardinal directions a robot can face.
 */
type Direction = 'north' | 'east' | 'south' | 'west';
/**
 * @typedef {[number, number]} Coordinates
 * Represents a position on a 2D grid as a tuple of x and y coordinates.
 */
type Coordinates = [number, number];

/**
 * Represents a robot that can move and turn on a 2D grid.
 *
 * A robot has a position (x, y) and a direction it is facing. It can be placed
 * at a specific location and executed a series of instructions.
 */
export class Robot {
  /**
   * @var direction The current direction the robot is facing.
   */
  private direction: Direction;
  /**
   * @var x The robot's current x-coordinate.
   */
  private x: number;
  /**
   * @var y The robot's current y-coordinate.
   */
  private y: number;

  /**
   * Initializes a new Robot instance.
   *
   * The robot starts at position [0, 0] facing 'north'.
   */
  constructor() {
    this.direction = "north";
    [this.x, this.y] = [0, 0];
  }

  /**
   * Gets the current direction the robot is facing.
   *
   * @returns The cardinal direction.
   */
  get bearing(): Direction {
    return this.direction;
  }

  /**
   * Gets the current coordinates of the robot.
   *
   * @returns A tuple of the x and y coordinates.
   */
  get coordinates(): Coordinates {
    return [this.x, this.y];
  }

  /**
   * Places the robot at a specific location and sets its initial direction.
   *
   * @param config An object containing the initial `x` coordinate, `y` coordinate, and `direction`.
   * @throws InvalidInputError If the provided direction is not valid.
   */
  public place({ x, y, direction }: { x: number; y: number; direction: string }) {
    [this.x, this.y] = [x, y];

    switch (direction) {
      case "north":
      case "south":
      case "west":
      case "east":
        this.direction = direction;
        return;
      default:
        throw new InvalidInputError(direction);
    }
  }

  /**
   * Executes a sequence of instructions.
   *
   * The instructions are a string where each character represents a command:
   * 'R' for turn right, 'L' for turn left, and 'A' for advance.
   *
   * @param instructions A string of one or more instructions.
   */
  public evaluate(instructions: string) {
    instructions
      .split("")
      .forEach(instruction => this.executeInstruction(instruction));
  }

  /**
   * Executes a single instruction for the robot.
   *
   * @param instruction The instruction character ('R', 'L', or 'A').
   * @throws InvalidInputError If the instruction character is not valid.
   */
  private executeInstruction(instruction: string) {
    switch (instruction) {
      case "R":
        this.turnRight();
        return;
      case "L":
        this.turnLeft();
        return;
      case "A":
        this.advance();
        return;
      default:
        throw new InvalidInputError(`Invalid instruction found: ${instruction}.`);
    }
  }

  /**
   * Turns the robot 90 degrees to the right relative to its current direction.
   */
  private turnRight() {
    switch (this.direction) {
      case "north":
        this.direction = "east";
        return;
      case "east":
        this.direction = "south";
        return;
      case "south":
        this.direction = "west";
        return;
      case "west":
        this.direction = "north";
        return;
    }
  }

  /**
   * Turns the robot 90 degrees to the left relative to its current direction.
   */
  private turnLeft() {
    switch (this.direction) {
      case "north":
        this.direction = "west";
        return;
      case "east":
        this.direction = "north";
        return;
      case "south":
        this.direction = "east";
        return;
      case "west":
        this.direction = "south";
        return;
    }
  }

  /**
   * Advances the robot one unit in its current direction.
   */
  private advance() {
    switch (this.direction) {
      case "north":
        this.y++;
        return;
      case "east":
        this.x++;
        return;
      case "south":
        this.y--;
        return;
      case "west":
        this.x--;
        return;
      default:
        return;
    }
  }
}