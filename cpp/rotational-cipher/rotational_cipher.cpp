#include "rotational_cipher.h"

namespace rotational_cipher {

char rotate(char chr, const unsigned int rotations) {
    const int alphabet_len = 26;

    if(islower(chr)) {
        return ((chr - 'a') + rotations) % alphabet_len + 'a';
    }

    if(isupper(chr)) {
        return ((chr - 'A') + rotations) % alphabet_len + 'A';
    }

    return chr;

}

std::string rotate(std::string msg, const unsigned int rotations) {
    std::string rotated = msg;

    for(unsigned int i = 0; i < msg.length(); i++) {
        rotated[i] = rotate(rotated[i], rotations);
    }

    return rotated;
}

}  // namespace rotational_cipher
