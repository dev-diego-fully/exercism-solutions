#include <algorithm>
#include <array>
#include <cmath>
#include <string>
#include <vector>

//not exporteds
int part_start( const int part_index, const int divisions,
                const int range_size ) {

    return part_index * range_size/divisions;

}

std::string rank_string(
    const int student_number, const std::string student_name,
    const int student_score
    ) {

    const std::string stringed_number = std::to_string(student_number);
    const std::string stringed_score = std::to_string(student_score);
    
    return stringed_number + ". " + student_name + ": " + stringed_score; 

}

//exporteds
// Round down all provided student scores.
std::vector<int> round_down_scores(std::vector<double> student_scores) {

    const int number_of_students = student_scores.size();
    std::vector<int> rounded_scores;

    for( int i = 0; i < number_of_students; i++ ) {

        const int rounded_score = floor( student_scores.at( i ) );

        rounded_scores.push_back( rounded_score );

    }
    
    return rounded_scores;

}

// Determine how many of the provided student scores were 'the best' based on the provided threshold.
std::vector<int> above_threshold(std::vector<int> student_scores,
                                 int threshold) {

    std::vector<int> above;
    const int number_of_students = student_scores.size();

    for( int i = 0; i < number_of_students; i++) {

        const int score = student_scores.at( i );
        if( score >= threshold ) {
            above.push_back( score );
        }

    }

    return above;

}

// Count the number of failing students out of the group provided.
int count_failed_students(std::vector<int> student_scores) {
    
    const int fail_below = 41;
    const std::vector<int> suceeds = above_threshold(
        student_scores, fail_below
    );
    const int succeeds_count = suceeds.size();
    const int failed_count = student_scores.size() - succeeds_count;

    return failed_count;

}

// Create a list of grade thresholds based on the provided highest grade.
std::array<int, 4> letter_grades(int highest_score) {

    const int fail_from = 40;
    const int pass_from = fail_from + 1;
    const int delta = highest_score - fail_from;
    const int non_f_grades_number = 4;
    
    std::array<int, 4> letter_grades;

    for( int i = 0; i < non_f_grades_number; i++ ) {
        const int letter_score_start = part_start(
            i, non_f_grades_number, delta
        );
        letter_grades[ i ] = ( pass_from + letter_score_start );
    }

    return letter_grades;

}

// Organize the student's rank, name, and grade information in ascending order.
std::vector<std::string> student_ranking(std::vector<int> student_scores, std::vector<std::string> student_names) {

    const int number_of_students = std::min(
        student_names.size(), student_scores.size()
    );

    std::vector<std::string> rankeds;

    for( int i = 0; i < number_of_students; i ++ ) {

        const int number = i + 1;
        const std::string name = student_names[ i ];
        const int score = student_scores[ i ];

        rankeds.push_back( rank_string( number, name, score ) );

    }

    return rankeds;

}

// Create a string that contains the name of the first student to make a perfect score on the exam.
std::string perfect_score(std::vector<int> student_scores, std::vector<std::string> student_names) {

    const int number_of_students = std::min(
        student_names.size(), student_scores.size()
    );

    for( int i = 0; i < number_of_students; i++ ) {
        if( student_scores.at( i ) == 100 ) {
            return student_names.at( i );
        }
    }

    return "";

}
