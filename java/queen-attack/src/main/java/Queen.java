class Queen {

    private final int row;
    private final int column;

    Queen(int row, int column) {
        this.row = row;
        this.column = column;
        QueenValidator.validateQueen(this);
    }

    int getRow() {
        return this.row;
    }

    int getColumn() {
        return this.column;
    }

    boolean sharesRow(Queen other) {
        return this.row == other.row;
    }

    boolean sharesColumn(Queen other) {
        return this.column == other.column;
    }

    boolean sharesDiagonal(Queen other) {
        final int colsDifference = Math.abs(this.column - other.column);
        final int rowsDifference = Math.abs(this.row - other.row);

        return colsDifference == rowsDifference;
    }

    boolean sharesSameSquare(Queen other) {
        return this.sharesRow(other) && this.sharesColumn(other);
    }

}
