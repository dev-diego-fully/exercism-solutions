/**
 * Implements Conway's Game of Life.
 *
 * This class simulates the evolution of a grid of cells based on a set of rules.
 * Each cell can be either alive or dead. The simulation advances in discrete
 * time steps, or "ticks."
 */
export class GameOfLife {
  /**
   * @var _state The current state of the game grid, represented as a matrix of numbers.
   */
  private _state: number[][];

  /**
   * Creates a new GameOfLife instance with a starting state.
   *
   * @param matrix The initial grid state. Alive cells are represented by non-zero numbers.
   */
  constructor(matrix: number[][]) {
    this._state = matrixCopy(matrix);
  }

  /**
   * Advances the game state by one generation.
   *
   * The new state is calculated based on the rules of Conway's Game of Life
   * applied to the current state.
   */
  public tick() {
    this._state = matrixMap(
      this._state,
      (_, x: number, y: number) => this.willAlive(x, y)
    );
  }

  /**
   * Returns a copy of the current state of the game grid.
   *
   * This method ensures that the internal state of the class cannot be
   * modified directly from outside.
   *
   * @returns A copy of the matrix representing the current state.
   */
  public state(): number[][] {
    return matrixCopy(this._state);
  }

  /**
   * Determines if a cell at a given position will be alive in the next generation.
   *
   * This is based on the number of its alive neighbors and the rules of the game.
   *
   * @param x The x-coordinate of the cell.
   * @param y The y-coordinate of the cell.
   * @returns 1 if the cell will be alive, 0 otherwise.
   */
  private willAlive(x: number, y: number): number {
    const aliveNeighboursCount = this.aliveNeighboursCount(x, y);

    if (aliveNeighboursCount === 3) {
      return 1;
    }
    if (aliveNeighboursCount === 2 && this.isAlive(x, y)) {
      return 1;
    }
    return 0;
  }

  /**
   * Counts the number of alive neighbors for a cell at a given position.
   *
   * @param x The x-coordinate of the cell.
   * @param y The y-coordinate of the cell.
   * @returns The count of alive neighbors.
   */
  private aliveNeighboursCount(x: number, y: number): number {
    const infLimitOfX = Math.max(x - 1, 0);
    const supLimitOfX = Math.min(x + 1, this._state.length - 1);
    const infLimitOfY = Math.max(y - 1, 0);
    const supLimitOfY = Math.min(y + 1, this._state.length - 1);

    let count = 0;

    for (let indexOfY = infLimitOfY; indexOfY <= supLimitOfY; indexOfY++) {
      for (let indexOfX = infLimitOfX; indexOfX <= supLimitOfX; indexOfX++) {
        if (indexOfY === y && indexOfX === x) {
          continue;
        }
        if (this._state[indexOfY][indexOfX] !== 0) {
          count++;
        }
      }
    }

    return count;
  }

  /**
   * Checks if a cell at a given position is alive.
   *
   * An alive cell is represented by a non-zero value.
   *
   * @param x The x-coordinate of the cell.
   * @param y The y-coordinate of the cell.
   * @returns True if the cell is alive, false otherwise.
   */
  private isAlive(x: number, y: number): boolean {
    return this._state[y][x] !== 0;
  }
}

/**
 * Creates a shallow copy of a 2D matrix.
 *
 * @template T The type of elements in the matrix.
 * @param matrix The matrix to copy.
 * @returns A new, independent matrix with the same elements.
 */
function matrixCopy<T>(matrix: T[][]): T[][] {
  return matrix.map(array => [...array]);
}

/**
 * Creates a new matrix by applying a mapper function to each element of an existing matrix.
 *
 * @template T The type of elements in the source matrix.
 * @template U The type of elements in the resulting matrix.
 * @param matrix The source matrix.
 * @param mapper The function to apply to each element. It receives the element, x, and y coordinates.
 * @returns A new matrix with the results of the mapper function.
 */
function matrixMap<T, U>(
  matrix: T[][],
  mapper: (element: T, x: number, y: number) => U
): U[][] {
  const result = newSquareMatrix<U>(matrix.length);

  for (let indexOfY = 0; indexOfY < matrix.length; indexOfY++) {
    for (let indexOfX = 0; indexOfX < matrix.length; indexOfX++) {
      result[indexOfY][indexOfX] = mapper(
        matrix[indexOfY][indexOfX],
        indexOfX, indexOfY
      );
    }
  }

  return result;
}

/**
 * Creates a new empty square matrix of a given length.
 *
 * @template T The type of elements the matrix will hold.
 * @param len The length of the sides of the square matrix.
 * @returns An empty square matrix.
 */
function newSquareMatrix<T>(len: number): T[][] {
  const result = [];

  for (let i = 0; i < len; i++) {
    result.push([]);
  }

  return result;
}