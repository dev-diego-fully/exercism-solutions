export function isIsogram(phrase: string): boolean {
  const nonLetterPattern = /[^a-zA-Z]/g;
  const foundLetters = new Set();
  const inEachChar = "";
  
  return phrase
    .replace(nonLetterPattern, "")
    .toLowerCase()
    .split(inEachChar)
    .every((letter) => {
      if (foundLetters.has(letter)) {
        return false;
      }
      foundLetters.add(letter);
      return true;
    });
}
