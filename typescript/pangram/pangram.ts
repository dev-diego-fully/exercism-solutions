export function isPangram(phrase: string): boolean {
  return (
    Array.from(
      new Set(
        phrase
          .replace(/[^a-zA-Z]/g, "")
          .toLowerCase()
          .split("")
      )
    ).length == alphabetSize
  );
}

const alphabetSize = 26;
