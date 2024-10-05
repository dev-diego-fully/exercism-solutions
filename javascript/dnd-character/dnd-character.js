function d6() {
  const [diceSides, diceMinValue] = [6, 1];
  return diceMinValue + Math.floor(Math.random() * diceSides);
}

export const abilityModifier = (abilityScore) => {
  if (abilityScore < 3) {
    throw new RangeError("Ability scores must be at least 3");
  }
  if (abilityScore > 18) {
    throw new RangeError("Ability scores can be at most 18");
  }
  return Math.floor(abilityScore / 2) - 5;
};

export class Character {

  #strength;
  #dexterity;
  #constituition;
  #intelligence;
  #wisdom;
  #charisma;

  static rollAbility() {
    return [0, 1, 2, 3]
      .map(d6)
      .sort()
      .slice(1)
      .reduce((sum, v) => sum + v);
  }

  get strength() {
    this.#strength = this.#strength ?? Character.rollAbility();
    return this.#strength;
  }

  get dexterity() {
    this.#dexterity = this.#dexterity ?? Character.rollAbility();
    return this.#dexterity;
  }

  get constitution() {
    this.#constituition = this.#constituition ?? Character.rollAbility();
    return this.#constituition;
  }

  get intelligence() {
    this.#intelligence = this.#intelligence ?? Character.rollAbility();
    return this.#intelligence;
  }

  get wisdom() {
    this.#wisdom = this.#wisdom ?? Character.rollAbility();
    return this.#wisdom;
  }

  get charisma() {
    this.#charisma = this.#charisma ?? Character.rollAbility();
    return this.#charisma;
  }

  get hitpoints() {
    return 10 + abilityModifier(this.#constituition);
  }
}
