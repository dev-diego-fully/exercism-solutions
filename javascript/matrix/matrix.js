//
// This is only a SKELETON file for the 'Matrix' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

/**
 * 
 * @param {any} element 
 * @param {any[][]} matrix 
 * @param {number} rowIndex 
 * @param {number} columnIndex 
 * @returns {any[][]}
 */
const putAt = ( element, matrix, rowIndex, columnIndex ) => {

  matrix[ rowIndex ] = matrix[ rowIndex ] ?? [];
  matrix[ rowIndex ][ columnIndex ] = element;

  return matrix;

}

export class Matrix {

  constructor( matrixString ) {

    this._matrix = Object.freeze(
      matrixString
        .split( "\n" )
        .map( ( row ) => row.split( " " ) )
        .map( ( row ) => row.map( ( element ) => Number( element ) ) )
    );

  }

  get rows() {

    return this._matrix;

  }

  get columns() {

    const columns = [];

    for( const rowIndex in this._matrix ) {

      for( const columnIndex in this._matrix[ rowIndex ] ) {

        putAt(
          this._matrix[ rowIndex ][ columnIndex ],
          columns, columnIndex, rowIndex
        );

      }

    }

    return columns;

  }
}
