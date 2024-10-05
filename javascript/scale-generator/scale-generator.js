//@ts-check
/**
 * @typedef {"C"|"C#"|"Db"|"D"|"D#"|"Eb"|"E"|"F"|"F#"|"Gb"|"G"|"G#"|"Ab"|"A"|"Bb"|"A#"|"B"} Note
 */
const SharpNotes = Object.freeze(
  ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
);
const FlatNotes = Object.freeze(
  ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"]
);

/**
 * 
 * @param {Note} note 
 * @returns {Note}
 */
function upperCaseNote(note) {
  // @ts-ignore
  return note.charAt(0).toUpperCase() + note.charAt(1) ?? "";
}

/**
 * 
 * @param {Note} note
 * @returns {boolean} 
 */
function usesSharps(note) {
  const sharpUsers = ['a','C', 'G', 'D', 'A', 'E', 'B', 'F#', 'e', 'b', 'f#', 'c#', 'g#', 'd#'];
  return sharpUsers.includes(note);
}

/**
 * 
 * @param {Note} note 
 * @returns {boolean}
 */
function usesFlats(note) {
  const minorUsers = ['F', 'Bb', 'Eb', 'Ab', 'Db', 'Gb', 'd', 'g', 'c', 'f', 'bb', 'eb'];
  return minorUsers.includes(note);
}

/**
 * 
 * @param {Note} note 
 * @returns {SharpNotes|FlatNotes}
 */
function getUsedNotes(note) {
  if(usesSharps(note)) {
    return SharpNotes;
  }
  if(usesFlats(note)){
    return FlatNotes;
  }
  throw new Error(note);
}

/**
 * 
 * @param {any[]|readonly any[]} list 
 * @param {number} index 
 * @returns {any}
 */
function circularIndexate(list, index) {
  const circIndex = index % list.length
  return list[circIndex];
}

/**
 * 
 * @param {string} interval
 * @returns {number} 
 */
function valueOfInterval(interval) {
  return {
    "m": 1,
    "M": 2,
    "A": 3
  }[interval] ?? -1;
}

export class Scale {

  #chromatic;

  /**
   * @param {Note} tonic
   */
  constructor(tonic) {
    const notes = getUsedNotes(tonic);
    const tonicIndex = notes.indexOf(upperCaseNote(tonic));
    this.#chromatic = Object.freeze(
      notes
        .map((_, index) => circularIndexate(notes, index + tonicIndex))
    );
  }

  chromatic() {
    return this.#chromatic;
  }

  /**
   * @param {string} intervals
   * @returns {Note[]}
   */
  interval(intervals) {
    if (intervals.match(/[^mMA]/)) {
      throw new Error();
    }
    const chromatic = this.#chromatic;
    return intervals
      .split("")
      .map(valueOfInterval)
      .reduce(
        /**
         * @param {number[]} indexes 
         * @param {number} value 
         * @returns {number[]}
         */
        (indexes, value) => {
          indexes.push(value + indexes[indexes.length - 1]);
          return indexes;
        },
        [0]
      )
      .map((index) => circularIndexate(this.#chromatic, index))
  }
}
