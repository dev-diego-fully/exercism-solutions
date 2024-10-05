#include "high_scores.h"
#include <algorithm>
#include <iterator>
#include <vector>


namespace arcade {

    std::vector<int> HighScores::list_scores() const {
        return this->scores;
    }

    int HighScores::latest_score() const {
        return this->scores.back();
    }

    int HighScores::personal_best() const {
        if(this->scores.empty()) {
            return -1;
        }
        int last_score = this->scores.front();

        for(const int score: this->scores) {
            if(score > last_score) {
                last_score = score;
            }
        }

        return last_score;
    }

    std::vector<int> HighScores::top_three() const {
        const int top_len = std::min((int)this->scores.size(), 3);

        std::vector<int> copy = this->scores;
        std::sort(copy.begin(), copy.end());
        std::reverse(copy.begin(), copy.end());

        return std::vector<int>(copy.begin(), copy.begin() + top_len);
    }

}  // namespace arcade
