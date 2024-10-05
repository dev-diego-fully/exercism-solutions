//
// This is only a SKELETON file for the 'Bank Account' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class BankAccount {

  #opened = false;
  #balance = 0;

  constructor() {
  }

  open() {
    if(this.#opened) {
      throw new ValueError();
    }
    this.#opened = true;
  }

  close() {
    if(!this.#opened) {
      throw new ValueError();
    }
    this.#opened = false;
    this.#balance = 0;
  }

  deposit(value) {
    if(!this.#opened) {
      throw new ValueError();
    }
    if(value < 0) {
      throw new ValueError();
    }
    this.#balance += value;
  }

  withdraw(value) {
    if(!this.#opened) {
      throw new ValueError();
    }
    if(value < 0) {
      throw new ValueError();
    }
    if(this.#balance < value) {
      throw new ValueError();
    }
    this.#balance -= value;
  }

  get balance() {
    if(!this.#opened) {
      throw new ValueError();
    }
    return this.#balance;
  }
}

export class ValueError extends Error {
  constructor() {
    super('Bank account error');
  }
}
