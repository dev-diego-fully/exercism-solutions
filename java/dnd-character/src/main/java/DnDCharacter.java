import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

class DnDCharacter {

    private int strength,
            constitution,
            dexterity,
            intelligence,
            wisdom,
            charisma;

    private final static Random random = new Random();

    public DnDCharacter() {
        this.strength = this.generateAbilityScore();
        this.dexterity = this.generateAbilityScore();
        this.constitution = this.generateAbilityScore();
        this.intelligence = this.generateAbilityScore();
        this.wisdom = this.generateAbilityScore();
        this.charisma = this.generateAbilityScore();
    }

    int ability(List<Integer> scores) {
        final int dropLowest = 1, keepHighest = 3;
        return scores
                .stream()
                .sorted()
                .skip(dropLowest)
                .limit(keepHighest)
                .reduce(0, Integer::sum);
    }

    List<Integer> rollDice() {
        final int dicesRolleds = 4, diceFaces = 6, minFace = 1;

        return IntStream
                .range(0, dicesRolleds)
                .map((_ignored) -> random.nextInt(minFace, diceFaces))
                .boxed()
                .collect(Collectors.toList());
    }

    int modifier(int input) {
        final int baseScore = 10;
        return Math.floorDiv(input - baseScore, 2);
    }

    int getStrength() {
        return this.strength;
    }

    int getDexterity() {
        return this.dexterity;
    }

    int getConstitution() {
        return this.constitution;
    }

    int getIntelligence() {
        return this.intelligence;
    }

    int getWisdom() {
        return this.wisdom;
    }

    int getCharisma() {
        return this.charisma;
    }

    int getHitpoints() {
        final int baseHp = 10;
        return baseHp + this.modifier(this.constitution);
    }

    private int generateAbilityScore() {
        return this.ability(this.rollDice());
    }

}
