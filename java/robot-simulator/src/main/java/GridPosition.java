class GridPosition {

    final int x;

    final int y;

    GridPosition(final int x, final int y) {
        this.x = x;
        this.y = y;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + x;
        result = prime * result + y;
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        } else if (obj == null || getClass() != obj.getClass()) {
            return false;
        } else if (x != ((GridPosition) obj).x || y != ((GridPosition) obj).y) {
            return false;
        } else {
            return true;
        }
    }

    GridPosition increaseadX() {
        return new GridPosition(
                this.x + 1,
                this.y);
    }

    GridPosition increaseadY() {
        return new GridPosition(
                this.x,
                this.y + 1);
    }

    GridPosition decreasedX() {
        return new GridPosition(
                this.x - 1,
                this.y);
    }

    GridPosition decreasedY() {
        return new GridPosition(
                this.x,
                this.y - 1);
    }
}
