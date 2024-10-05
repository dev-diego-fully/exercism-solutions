#include "atbash_cipher.h"
#include <cstddef>

namespace atbash_cipher {


char encode_char(const char ch) {
    const std::string plain_alphabet = "abcdefghijklmnopqrstuvwxyz";
    const std::string cipher_alphabet = "zyxwvutsrqponmlkjihgfedcba";
    const std::string digits = "0123456789";

    const size_t plain_index = plain_alphabet.find(tolower(ch));
    
    if(plain_index < plain_alphabet.length()) {
        return cipher_alphabet[plain_index];
    }
    
    if(digits.find(ch) < digits.length()) {
        return ch;
    }
    
    return ' ';
}

char decode_char(const char ch) {
    const std::string plain_alphabet = "abcdefghijklmnopqrstuvwxyz";
    const std::string cipher_alphabet = "zyxwvutsrqponmlkjihgfedcba";
    const std::string digits = "0123456789";

    if(digits.find(ch) < digits.length()) {
        return ch;
    }

    return plain_alphabet[cipher_alphabet.find(ch)];
}

std::string clean(std::string to_clean) {
    std::string cleaned = "";
    for(size_t i = 0; i < to_clean.length(); i++) {
        if(to_clean[i] != ' ') {
            cleaned += to_clean[i];
        }
    }
    return cleaned;
}

std::string split(std::string to_clean) {
    const size_t group_size = 5;
    const size_t space_interval = 6;

    std::string splitted = "";
    
    for(size_t i = 0; i < to_clean.length(); i++) {
        if(splitted.length() % space_interval == group_size) {
            splitted += " ";
        }
        splitted += to_clean[i];
    }

    return splitted;
}

//exporteds

std::string encode(std::string msg) {
    for(size_t i = 0; i < msg.length(); i++) {
        msg[i] = encode_char(msg[i]);
    }
    
    return split(clean(msg));
}

std::string decode(const std::string encoded) {
    std::string decoded = clean(encoded);
    
    for(size_t i = 0; i < decoded.length(); i++) {
        decoded[i] = decode_char(decoded[i]);
    }

    return decoded;
}











}  // namespace atbash_cipher
