export function count(str: string): Map<string, number> {
  return words(str).reduce(countWord, new Map());
}

function words(str: string): string[] {
  const pattern = /[a-z\d]+\'?[a-z\d]+|\b[a-z\d]*[a-z]\'|[a-z\d]+/gi;
  return str.match(pattern) ?? [];
}

function countWord(
  counter: Map<string, number>,
  word: string
): Map<string, number> {
  const trueWord: string = word.toLowerCase();
  counter.set(trueWord.toLowerCase(), (counter.get(trueWord) ?? 0) + 1);
  return counter;
}
