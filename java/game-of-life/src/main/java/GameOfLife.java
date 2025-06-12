class GameOfLife {
    public int[][] tick(int[][] matrix) {
    	return (new GameState(matrix)).updated().getRawState();
    }
}
