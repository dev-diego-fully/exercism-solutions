#pragma once

#include <vector>
#include <algorithm>


namespace arcade {

class HighScores {
   private:
    std::vector<int> scores;

   public:
    HighScores(std::vector<int> scores) : scores(scores){};

    std::vector<int> list_scores() const;

    int latest_score() const;

    int personal_best() const;

    std::vector<int> top_three() const;
};

}  // namespace arcade
