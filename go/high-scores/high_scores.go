// Package highscores provides functionality for managing player scores and retrieving personal bests.
package highscores

import "slices"

// HighScores represents a collection of player scores.
type HighScores struct {
	scores []int
}

// NewHighScores returns a new HighScores instance initialized with the given scores.
func NewHighScores(scores []int) *HighScores {
	return &HighScores{
		scores: scores,
	}
}

// Scores returns all the recorded scores.
func (s *HighScores) Scores() []int {
	return s.scores
}

// Latest returns the latest (last recorded) score.
func (s *HighScores) Latest() int {
	return s.scores[len(s.scores)-1]
}

// PersonalBest returns the best (highest) score.
func (s *HighScores) PersonalBest() int {
	best := s.scores[0]

	for _, v := range s.scores {
		if v > best {
			best = v
		}
	}

	return best
}

// TopThree returns the top three highest scores in descending order.
func (s *HighScores) TopThree() []int {
	topThree := make([]int, 0)

	for _, v := range s.scores {
		topThree = pickBest(v, 3, topThree)
	}

	return topThree
}

// pickBest updates the output slice to contain up to count highest elements, maintaining descending order.
func pickBest(candidate, count int, output []int) []int {
	if len(output) < count {
		output = append(output, candidate)

		slices.SortFunc(output, func(a, b int) int { return b - a })
		return output
	}

	current := candidate

	for i, v := range output {
		if current > v {
			temp := output[i]
			output[i] = current
			current = temp
		}
	}

	return output
}
