export class Anagram {
  readonly word: string;
  private sorted: string;

  constructor(input: string) {
    this.word = input.toLowerCase();
    this.sorted = this.word.split("").sort().join("");
  }

  public matches(...potentials: string[]): string[] {
    return potentials.filter(this.isAnagram.bind(this));
  }

  private isAnagram(word: string): boolean {
    const normalized: string = word.toLowerCase();
    if (normalized === this.word) {
      return false;
    }

    const chars = normalized.split("").sort().join("");
    return chars === this.sorted;
  }
}
