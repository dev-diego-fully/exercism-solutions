export class Gigasecond {
  private static readonly giga: number = 1e9;
  private initialDate: Date;

  public constructor(initialDate: Date) {
    this.initialDate = initialDate;
  }

  public date(): Date {
    const nextDate = new Date(this.initialDate);
    nextDate.setUTCSeconds(this.initialDate.getUTCSeconds() + Gigasecond.giga);
    return nextDate;
  }
}
