#include "bob.h"

namespace bob {

bool contains_upper_case(const std::string message) {
    for(const char c: message){
        if(isupper(c)) {
            return true;
        }
    }
    return false;
}

bool contains_lower_case(const std::string message) {
    for(const char c: message) {
        if(islower(c)) {
            return true;
        }
    }
    return false;
}

bool is_question(const std::string message) {
    std::string rev_message = message;
    std::reverse(rev_message.begin(), rev_message.end());
    
    for(const char c: rev_message) {
        if(c == '?') {
            return true;
        }
        if(!isspace(c)) {
            return false;
        }
    }
    
    return false;
}

bool is_yell(const std::string message) {
    return contains_upper_case(message) && !contains_lower_case(message);
}

bool is_silence(const std::string message) {
    for(const char c: message) {
        if(!isspace(c)) {
            return false;
        }
    }
    return true;
}

std::string hey(const std::string message) {
    const std::string answer_for_silences = "Fine. Be that way!";
    const std::string answer_for_questions = "Sure.";
    const std::string answer_for_yells = "Whoa, chill out!";
    const std::string answer_for_yelling_questions = "Calm down, I know what I'm doing!";
    const std::string default_awsner = "Whatever.";

    if(is_silence(message)) {
        return answer_for_silences;
    }

    const bool is_yelling = is_yell(message);
    const bool is_questioning = is_question(message);

    if(is_yelling && is_questioning) {
        return answer_for_yelling_questions;
    }

    if(is_questioning) {
        return answer_for_questions;
    }

    if(is_yelling) {
        return answer_for_yells;
    }

    return default_awsner;
}

}  // namespace bob
