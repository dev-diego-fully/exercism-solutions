/**
 * Represents a matrix (grade) of numbers, allowing extraction of rows and columns.
 *
 * The matrix is initialized from a string input where rows are separated by newlines
 * and numbers within a row are separated by spaces.
 */
export class Matrix {
  /**
   * @var inner The internal 2D array representing the matrix's numerical data.
   */
  private inner: number[][];

  /**
   * Creates a new Matrix instance from a string representation.
   *
   * @param matrix A string where each row is separated by '\n' and numbers in a row by ' '.
   */
  constructor(matrix: string) {
    this.inner = matrix
      .split('\n')
      .map(row => row.split(' ').map(Number));;
  }

  /**
   * Gets all rows of the matrix.
   *
   * Each row is returned as a new array, ensuring the original internal state
   * cannot be modified directly.
   *
   * @returns An array of arrays, where each inner array is a row of the matrix.
   *
   * @example
   * // For a matrix '1 2\n3 4'
   * new Matrix('1 2\\n3 4').rows; // Returns [[1, 2], [3, 4]]
   * new Matrix('1 2\\n3 4').rows[1]; // Returns [3, 4]
   */
  get rows(): number[][] {
    return this.inner.map(row => row.map(v => v));
  }

  /**
   * Gets all columns of the matrix.
   *
   * Each column is returned as a new array.
   *
   * @returns An array of arrays, where each inner array is a column of the matrix.
   *
   * @example
   * // For a matrix '1 2 3\n4 5 6\n7 8 9'
   * new Matrix('1 2 3\\n4 5 6\\n7 8 9').columns; // Returns [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
   */
  get columns(): number[][] {
    return Array
      .from(range(this.columnsCount))
      .map((index) => this.column(index));
  }

  /**
   * Extracts a specific column from the matrix by its index.
   *
   * @param index The zero-based index of the column to extract.
   * @returns An array of numbers representing the specified column.
   *
   * @example
   * // For a matrix '1 2 3\n4 5 6\n7 8 9'
   * new Matrix('1 2 3\\n4 5 6\\n7 8 9').column(2); // Returns [3, 6, 9]
   */
  public column(index: number): number[] {
    return Array
      .from(range(this.rowsCount))
      .map(row => this.inner[row][index]);
  }

  /**
   * Gets the number of columns in the matrix.
   *
   * @returns The count of columns.
   */
  private get columnsCount(): number {
    return this.inner[0].length;
  }

  /**
   * Gets the number of rows in the matrix.
   *
   * @returns The count of rows.
   */
  private get rowsCount(): number {
    return this.inner.length;
  }
}

/**
 * A generator function that yields a sequence of numbers from 0 up to (but not including) `end`.
 *
 * This is a utility function for iterating a specific number of times.
 *
 * @param end The upper limit (exclusive) of the sequence.
 * @yields The next number in the sequence.
 *
 * @example
 * Array.from(range(3)); // Returns [0, 1, 2]
 */
function* range(end: number): Generator<number, void, unknown> {
  for (let i = 0; i < end; i++) {
    yield i;
  }
}