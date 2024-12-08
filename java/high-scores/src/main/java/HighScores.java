import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class HighScores {

    private final List<Integer> highScores;

    public HighScores(List<Integer> highScores) {
        this.highScores = new ArrayList<Integer>(highScores);
    }

    public List<Integer> scores() {
        return new ArrayList<Integer>(this.highScores);
    }

    public Integer latest() {
        return this.highScores
                .get(this.highScores.size() - 1);
    }

    public Integer personalBest() {
        return Collections
                .max(this.highScores);
    }

    public List<Integer> personalTopThree() {
        return this.highScores
                .stream()
                .sorted((a, b) -> b - a)
                .limit(3)
                .toList();
    }

}
