export function isIsogram(phrase: string): boolean {
  const nonLetterPattern = /[^a-zA-Z]/g;
  const foundLetters = new Set();
  
  return phrase
    .replace(nonLetterPattern, "")
    .toLowerCase()
    .split("")
    .every((letter) => {
      if (foundLetters.has(letter)) {
        return false;
      }
      foundLetters.add(letter);
      return true;
    });
}
