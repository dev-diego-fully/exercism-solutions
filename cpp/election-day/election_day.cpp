#include <string>
#include <vector>

namespace election {

// The election result struct is already created for you:

struct ElectionResult {
    // Name of the candidate
    std::string name{};
    // Number of votes the candidate has
    int votes{};
};

// vote_count takes a reference to an `ElectionResult` as an argument and will
// return the number of votes in the `ElectionResult.
int vote_count( ElectionResult& election_result ) {

    return election_result.votes;

}

// increment_vote_count takes a reference to an `ElectionResult` as an argument
// and a number of votes (int), and will increment the `ElectionResult` by that
// number of votes.
void increment_vote_count( ElectionResult& incremented, int value ) {

    incremented.votes += value;

}

// determine_result receives the reference to a final_count and returns a
// reference to the `ElectionResult` of the new president. It also changes the
// name of the winner by prefixing it with "President". The final count is given
// in the form of a `reference` to `std::vector<ElectionResult>`, a vector with
// `ElectionResults` of all the participating candidates.
ElectionResult& determine_result( std::vector<ElectionResult>& final_count ) {

    const std::string president_prefix = "President ";
    const int number_of_candidates = final_count.size();
    int most_voted_index = 0;

    for( int i = 0; i < number_of_candidates; i++ ) {

        ElectionResult& current = final_count.at( i );
        ElectionResult& most_voted = final_count.at( most_voted_index );

        if(current.votes > most_voted.votes)
            most_voted_index = i;

    }

    ElectionResult& most_voted = final_count.at( most_voted_index );
    most_voted.name = president_prefix + most_voted.name;

    return most_voted;

}

}  // namespace election