//
// This is only a SKELETON file for the 'Transpose' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const transpose = (arr) => {
  let matrix = [];

  for(let i = 0; i < arr.length; i++){
    for(let j = 0; j < arr[i].length; j++){
      let rowLength = 0;
      let elem = arr[i][j];

      if (matrix[j]){
        rowLength = matrix[j].length;
      }

      if (i > rowLength){
        elem = elem.padStart(i - rowLength + 1, " ");
      }
      matrix[j] ? matrix[j] += elem : matrix[j] = elem;
    }
  }
  return matrix;
};