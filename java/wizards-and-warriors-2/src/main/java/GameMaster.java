public class GameMaster {

    public String describe(Character character) {
        final String charDesciptionTemplate = "You're a level %d %s with %d hit points.";

        final int level = character.getLevel();
        final String charClass = character.getCharacterClass();
        final int hp = character.getHitPoints();

        return String.format(charDesciptionTemplate, level, charClass, hp);
    }

    public String describe(Destination destination) {
        final String destinationDescriptionTemplate = "You've arrived at %s, which has %d inhabitants.";

        final String name = destination.getName();
        final int inhabitants = destination.getInhabitants();

        return String.format(destinationDescriptionTemplate, name, inhabitants);
    }

    public String describe(TravelMethod travelMethod) {
        final String horsebackMsg = "You're traveling to your destination on horseback.";
        final String walkingMsg = "You're traveling to your destination by walking.";

        if (travelMethod == TravelMethod.HORSEBACK) {
            return horsebackMsg;
        }

        return walkingMsg;
    }

    public String describe(Character traveller, Destination destination, TravelMethod method) {
        final String travellingDescriptionTemplate = "%s %s %s";

        final String characterDescription = this.describe(traveller);
        final String destinationDescription = this.describe(destination);
        final String travelMethodDescription = this.describe(method);

        return String.format(
            travellingDescriptionTemplate,
            characterDescription,
            travelMethodDescription,
            destinationDescription
        );
    }
    
    public String describe(Character traveller, Destination destination) {
        return this.describe(traveller, destination, TravelMethod.WALKING);
    }

}
