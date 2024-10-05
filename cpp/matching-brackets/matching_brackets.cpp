#include "matching_brackets.h"


namespace matching_brackets {

bool is_opening(const char chr) {
    switch(chr) {
        case '(':
        case '{':
        case '[':
            return true;
        default:
            return false;
    }
}

bool is_closening(const char chr) {
    switch (chr) {
        case ')':
        case '}':
        case ']':
            return true;
        default:
            return false;
    }
}

char closer_of(const char chr) {
    switch (chr) {
        case '{':
            return '}';
        case '(':
            return ')';
        case '[':
            return ']';
        default:
            return ' ';
    }
}

bool closes(const char closer, const char to_be_closed) {
    return closer == closer_of(to_be_closed);
}

bool check(const std::string input) {
    std::vector<char> stack;

    for(const char c: input) {
        if(is_opening(c)) {
            stack.push_back(c);
            continue;
        }
        if(!is_closening(c)) {
            continue;
        }
        if(stack.empty()) {
            return false;
        }
        if(!closes(c, stack.back())) {
            return false;
        }
        stack.pop_back();
    }

    return stack.empty();
}

}  // namespace matching_brackets
