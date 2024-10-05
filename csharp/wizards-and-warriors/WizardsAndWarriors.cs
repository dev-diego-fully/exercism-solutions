using System;

abstract class Character
{
    public readonly string characterType;

    protected Character(string characterType)
    {
        this.characterType = characterType;
    }

    public abstract int DamagePoints(Character target);

    public virtual bool Vulnerable()
        => false;

    public override string ToString()
        => $"Character is a {this.characterType}";

}

class Warrior : Character
{

    public static readonly int vulnerableDamage = 10;
    public static readonly int nonVulnerableDamage = 6;
    public Warrior() : base("Warrior") { }

    public override int DamagePoints(Character target)
        => target.Vulnerable() ? vulnerableDamage : nonVulnerableDamage;


}

class Wizard : Character
{
    public static readonly int preparedDamage = 12;
    public static readonly int nonPreparedDamage = 3;

    private bool preparedSpell = false;

    public Wizard() : base("Wizard") { }

    public override bool Vulnerable() => !this.preparedSpell;

    public override int DamagePoints(Character target)
        =>  this.preparedSpell ? preparedDamage : nonPreparedDamage;

    public void PrepareSpell()
        => this.preparedSpell = true;
    
}
