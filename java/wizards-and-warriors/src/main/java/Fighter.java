class Fighter {

    //methods
    boolean isVulnerable() {
        return true;
    }

    int getDamagePoints(Fighter fighter) {
        return 1;
    }
    
}


class Warrior extends Fighter {

    //Override Object
    @Override
    public String toString() {
        return "Fighter is a Warrior";
    }

    //Override Fighter
    @Override
    public boolean isVulnerable() {
        return false;
    }

    @Override
    public int getDamagePoints(Fighter target) {
        final int vulnerableDamage = 10;
        final int nonVulnerableDamage = 6;

        if (target.isVulnerable()) {
            return vulnerableDamage;
        }

        return nonVulnerableDamage;
    }

}


class Wizard extends Fighter {

    //attributes
    private boolean spellPrepared = false;

    //Override Object
    @Override
    public String toString() {
        return "Fighter is a Wizard";
    }

    //Override Fighter
    @Override
    public boolean isVulnerable() {
        return !this.spellPrepared;
    }

    @Override
    public int getDamagePoints(Fighter _target) {
        final int preparedSpellDamage = 12;
        final int nonPreparedSpellDamage = 3;

        if(this.spellPrepared) {
            return preparedSpellDamage;
        }

        return nonPreparedSpellDamage;
    }

    //Wizard methods
    public void prepareSpell() {
        this.spellPrepared = true;
    }
}