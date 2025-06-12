import java.util.function.BiFunction;

class GameState {

	private int[][] state;

	GameState(int[][] state) {
		this.state = state;
	}

	GameState updated() {
		GameState next = this.emptyCopy();

		next.updateCells(this::willAlive);

		return next;
	}

	int[][] getRawState() {
		return this.state;
	}

	private GameState emptyCopy() {
		int[][] state = new int[this.state.length][];

		for (int line = 0; line < state.length; line++) {
			state[line] = new int[this.state[line].length];
		}

		return new GameState(state);
	}

	private void updateCells(BiFunction<Integer, Integer, Boolean> updater) {
		for (int y = 0; y < this.state.length; y++) {
			for (int x = 0; x < this.state[y].length; x++) {
				this.setCell(x, y, updater.apply(x, y));
			}
		}
	}

	private boolean willAlive(int x, int y) {
		final int aliveNeighbors = this.aliveNeighborsCount(x, y);

		return aliveNeighbors == 3 || (aliveNeighbors == 2 && this.isCellAlive(x, y));
	}

	private boolean isCellAlive(int x, int y) {
		if (y < 0 || y >= this.state.length) {
			return false;
		}
		if (x < 0 || x >= this.state[y].length) {
			return false;
		}
		return this.state[y][x] != 0;
	}

	private void setCell(int x, int y, boolean willAlive) {
		this.state[y][x] = willAlive ? 1 : 0;
	}

	private int aliveNeighborsCount(int x, int y) {
		int count = 0;

		for (int ny = y - 1; ny <= y + 1; ny++) {
			for (int nx = x - 1; nx <= x + 1; nx++) {
				if(nx == x & ny == y) {
					continue;
				}
				if (this.isCellAlive(nx, ny)) {
					count++;
				}
			}
		}

		return count;
	}

}
