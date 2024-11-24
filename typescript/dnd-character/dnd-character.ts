export class DnDCharacter {
  public static generateAbilityScore(): number {
    const dicesRolleds: number = 4;
    const dicesDropeds: number = 1;

    return Array.from({ length: dicesRolleds }, d6)
      .sort()
      .slice(dicesDropeds)
      .reduce((sum, x) => sum + x);
  }

  public static getModifierFor(abilityValue: number): number {
    const averageScore = 10;
    const scaling = 2;

    return Math.floor((abilityValue - averageScore) / scaling);
  }

  private _strength: number;
  private _dexterity: number;
  private _constitution: number;
  private _intelligence: number;
  private _wisdom: number;
  private _charisma: number;

  public constructor() {
    [
      this._strength,
      this._dexterity,
      this._constitution,
      this._intelligence,
      this._wisdom,
      this._charisma,
    ] = Array.from({ length: 6 }, DnDCharacter.generateAbilityScore);
  }

  public get strength(): number {
    return this._strength;
  }

  public get dexterity(): number {
    return this._dexterity;
  }

  public get constitution(): number {
    return this._constitution;
  }

  public get intelligence(): number {
    return this._intelligence;
  }

  public get wisdom(): number {
    return this._wisdom;
  }

  public get charisma(): number {
    return this._charisma;
  }

  public get hitpoints(): number {
    const baseHitpoints: number = 10;

    return baseHitpoints + DnDCharacter.getModifierFor(this.constitution);
  }
}

function d6(): number {
  return 1 + Math.floor(6 * Math.random());
}
