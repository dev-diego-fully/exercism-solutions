import java.util.Map;

class Robot {

    private static final  Map<Orientation, Orientation> LEFT_ROTATION = Map.ofEntries(
            Map.entry(Orientation.NORTH, Orientation.WEST),
            Map.entry(Orientation.WEST, Orientation.SOUTH),
            Map.entry(Orientation.SOUTH, Orientation.EAST),
            Map.entry(Orientation.EAST, Orientation.NORTH));
    
    private static final Map<Orientation, Orientation> RIGHT_ROTATION = Map.ofEntries(
            Map.entry(Orientation.NORTH, Orientation.EAST),
            Map.entry(Orientation.EAST, Orientation.SOUTH),
            Map.entry(Orientation.SOUTH, Orientation.WEST),
            Map.entry(Orientation.WEST, Orientation.NORTH));

    private GridPosition position;
    private Orientation orientation;

    Robot(GridPosition initialPosition, Orientation initialOrientation) {
        this.orientation = initialOrientation;
        this.position = initialPosition;
    }

    GridPosition getGridPosition() {
        return this.position;
    }

    Orientation getOrientation() {
        return this.orientation;
    }

    void advance() {
        int newX = this.position.x;
        int newY = this.position.y;

        if(this.orientation == Orientation.NORTH) {
            newY++;

        } else if(this.orientation == Orientation.SOUTH) {
            newY--;

        } else if(this.orientation == Orientation.EAST) {
            newX++;

        } else {
            newX--;
        }

        this.position = new GridPosition(
            newX, newY
        );
    }

    void turnLeft() {
        this.orientation = Robot.LEFT_ROTATION.get(this.orientation);
    }

    void turnRight() {
        this.orientation = Robot.RIGHT_ROTATION.get(this.orientation);
    }

    void simulate(String instructions) {
        instructions
                .chars()
                .forEach(this::execute);
    }

    private void execute(int command) {
        switch (command) {
            case 'L':
                this.turnLeft();
                break;
            case 'R':
                this.turnRight();
                break;
            case 'A':
                this.advance();
                break;
            default:
                throw new IllegalArgumentException(Integer.toString(command));
        }
    }

}