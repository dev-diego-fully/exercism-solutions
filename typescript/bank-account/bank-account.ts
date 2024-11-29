export class ValueError extends Error {
  constructor() {
    super("Bank account error");
  }
}

export class BankAccount {
  private isOpen: boolean = false;
  private _balance: number = 0;

  open(): void {
    if (this.isOpen) {
      throw new ValueError();
    }
    this.isOpen = true;
  }

  close(): void {
    if (!this.isOpen) {
      throw new ValueError();
    }
    this.isOpen = false;
    this._balance = 0;
  }

  deposit(amount: number): void {
    if (!this.isOpen || amount < 0) {
      throw new ValueError();
    }
    this._balance += amount;
  }

  withdraw(amount: number): void {
    if (!this.isOpen || amount < 0 || amount > this._balance) {
      throw new ValueError();
    }
    this._balance -= amount;
  }

  get balance(): number {
    if (!this.isOpen) {
      throw new ValueError();
    }
    return this._balance;
  }
}
