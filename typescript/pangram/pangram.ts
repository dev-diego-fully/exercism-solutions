export function isPangram(phrase: string): boolean {
  return (
    new Set(
      phrase
        .replace(/[^a-zA-Z]/g, "")
        .toLowerCase()
        .split("")
    ).size == alphabetSize
  );
}

const alphabetSize = 26;
