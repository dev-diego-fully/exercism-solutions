package electionday

import "fmt"

// NewVoteCounter returns a new vote counter with
// a given number of initial votes.
func NewVoteCounter(initialVotes int) *int {
	var votingCount int = initialVotes

	return &votingCount
}

// VoteCount extracts the number of votes from a counter.
func VoteCount(counter *int) int {
	const missingVotes int = 0

	if counter == nil {
		return missingVotes
	}

	return *counter
}

// IncrementVoteCount increments the value in a vote counter.
func IncrementVoteCount(counter *int, increment int) {
	if counter != nil {
		*counter += increment
	}
}

// NewElectionResult creates a new election result.
func NewElectionResult(candidateName string, votes int) *ElectionResult {
	var electionResult ElectionResult = ElectionResult{
		Name:  candidateName,
		Votes: votes,
	}

	return &electionResult
}

// DisplayResult creates a message with the result to be displayed.
func DisplayResult(result *ElectionResult) string {
	const displayTemplate string = "%s (%d)"
	const messageImpossible string = ""

	if result == nil {
		return messageImpossible
	}

	return fmt.Sprintf(displayTemplate, result.Name, result.Votes)
}

// DecrementVotesOfCandidate decrements by one the vote count of a candidate in a map.
func DecrementVotesOfCandidate(results map[string]int, candidate string) {
	results[candidate] -= 1
}
