class Robot {

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
        this.position = switch (this.orientation) {
            case NORTH -> this.position.increaseadY();
            case EAST -> this.position.increaseadX();
            case SOUTH -> this.position.decreasedY();
            case WEST -> this.position.decreasedX();
        };
    }

    void turnLeft() {
        this.orientation = switch (this.orientation) {
            case NORTH -> Orientation.WEST;
            case EAST -> Orientation.NORTH;
            case SOUTH -> Orientation.EAST;
            case WEST -> Orientation.SOUTH;
        };
    }

    void turnRight() {
        this.orientation = switch (this.orientation) {
            case NORTH -> Orientation.EAST;
            case EAST -> Orientation.SOUTH;
            case SOUTH -> Orientation.WEST;
            case WEST -> Orientation.NORTH;
        };
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