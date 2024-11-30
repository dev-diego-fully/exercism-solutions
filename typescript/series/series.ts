export class Series {
  readonly original: string;
  private readonly splitted: number[];

  constructor(series: string) {
    if (series.length < 1) {
      throw new Error("series cannot be empty");
    }
    this.original = series;
    this.splitted = series.split("").map(Number);
  }

  slices(sliceLength: number) {
    if (sliceLength < 0) {
      throw new Error("slice length cannot be negative");
    }
    if (sliceLength === 0) {
      throw new Error("slice length cannot be zero");
    }
    if (sliceLength > this.original.length) {
      throw new Error("slice length cannot be greater than series length");
    }
    return Array.from(
      { length: this.original.length - sliceLength + 1 },
      (_, start) => this.splitted.slice(start, start + sliceLength)
    );
  }
}
